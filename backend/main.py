from contextlib import asynccontextmanager
from os import stat
from typing import Annotated
from fastapi import FastAPI, HTTPException, Path, Request, Response, UploadFile, status
import json
from dotenv import dotenv_values
import tempfile
import tarfile
from src.db.image import ImageDB
from pymongo import MongoClient
from src.image import generate_image, decompress_file, generate_thumbnail
from fastapi.security import OAuth2PasswordBearer
from fastapi.middleware.cors import CORSMiddleware
from src.db.logicalogin import cadastro_professor, autenticar_professor

config = dotenv_values(".env")


@asynccontextmanager
async def lifespan(app: FastAPI):
    # on startup
    app.mongodb_client = MongoClient(config["DB_URI"])
    app.database = app.mongodb_client[config["DB_NAME"]]
    yield
    # on shutdown
    app.mongodb_client.close()
    
app = FastAPI(lifespan=lifespan)    
app.add_middleware(CORSMiddleware,
                   allow_origins="*",
                   allow_credentials=True,
                   allow_methods=["*"],
                   allow_headers=["*"],
                   )

def getDatabase(collection_name : str):
    return app.database[collection_name]

@app.get("/")
async def root():
    return {"message": "Hello World"}

@app.post("/image", status_code=status.HTTP_201_CREATED)
async def upload_image(file: UploadFile):
    image_directory = decompress_file(file)
    filename = generate_image(image_directory)
    if not filename:
        raise HTTPException(status_code=status.HTTP_412_PRECONDITION_FAILED, detail="Houve um erro ao tentar criar a imagem")
    imagedb = ImageDB(filename.split("/")[0], getDatabase(ImageDB.collection_name))
    imagedb.save_image(filename)
    imagedb.db = getDatabase("image_info")
    imagedb.save_thumbnail(generate_thumbnail(image_directory))
    return {"message" : "sucesso"}


@app.get("/image/{image_name}/{z}/{x}/{y}")
async def get_image(image_name : Annotated[str, Path()], x : Annotated[int, Path()],
                    y : Annotated[int, Path()], z : Annotated[int, Path()]):
    imagedb = ImageDB(image_name, getDatabase(ImageDB.collection_name))
    file = imagedb.get_image(f"{z}/{x}/{y}")
    if file is None:
        return None
    return Response(file)

@app.get("/thumbnail/{image_name}")
async def get_thumbnail(image_name : Annotated[str, Path()]):
    imagedb = ImageDB(image_name, getDatabase("image_info"))
    file = imagedb.get_thumbnail()
    if file is None:
        return None
    return Response(file)


@app.get("/categories")
async def get_categories():
    pass

@app.post('/register')
async def register(request: Request):
    data = await request.json()
    email_professor = data.get('email_professor')
    nome = data.get('nome_professor')
    senha = data.get('senha')

    if not email_professor or not senha or not nome:
        return {'success': False, 'message': 'Email, nome e senha são obrigatórios.'}

    mensagem = cadastro_professor(app.database, email_professor,nome, senha)
    if "sucesso" in mensagem.lower():
        return {'success': True, 'message': mensagem}
    else:
        return {'success': False, 'message': mensagem}

@app.post('/login')
async def login(request: Request):
    data = await request.json()
    print(data)
    email_professor = data['email']
    senha = data['password']

    print(f"Recebida tentativa de login para: {email_professor}")
    print(f"Senha fornecida: {senha}")

    if not email_professor or not senha:
        print("Erro: Email e senha são obrigatórios.")
        return {'success': False, 'message': 'Email e senha são obrigatórios.'}

    senha_correta, is_admin = autenticar_professor(app.database,email_professor, senha)
    if senha_correta:
        print(f"Login bem-sucedido para: {email_professor}, isAdmin: {is_admin}")
        return {'success': True, 'message': 'Login realizado com sucesso!', 'numero_cliente': email_professor, 'is_admin': is_admin}
    else:
        print(f"Falha no login para: {email_professor}")
        return {'success': False, 'message': 'Credenciais inválidas.'}
