from contextlib import asynccontextmanager
from os import stat
from typing import Annotated
from fastapi import FastAPI, Form, HTTPException, Path, Request, Response, UploadFile, status
import json
from dotenv import dotenv_values
import tempfile
from starlette.status import HTTP_401_UNAUTHORIZED, HTTP_406_NOT_ACCEPTABLE
from src.db import category
from src.db.category import CategoryDB
from src.db.image import ImageDB
from pymongo import MongoClient
from src.image import generate_image, decompress_file, generate_thumbnail
from fastapi.security import OAuth2PasswordBearer
from fastapi.middleware.cors import CORSMiddleware
from src.db.logicalogin import cadastro_professor, autenticar_professor,deletar_professor

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
async def upload_image(file: UploadFile, image_name : str = Form(), image_description : str = Form()):
    image_directory = decompress_file(file)
    filename = generate_image(image_directory)
    if not filename:
        raise HTTPException(status_code=status.HTTP_412_PRECONDITION_FAILED, detail="Houve um erro ao tentar criar a imagem")
    imagedb = ImageDB(image_name, getDatabase(ImageDB.collection_name))
    imagedb.save_image(filename)
    imagedb.db = getDatabase("image_info")
    imagedb.save_thumbnail(generate_thumbnail(image_directory), image_description)
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
    categorydb = CategoryDB(getDatabase(CategoryDB.collection_name))
    categories = categorydb.get_category_images()
    return {"categories" : categories}

@app.post("/category")
async def create_category(request : Request):
    categorydb = CategoryDB(getDatabase(CategoryDB.collection_name))
    data = await request.json()
    category_name = data.get("category_name")
    images = data.get("images")
    categorydb.create_category(category_name, images)
    return {"message" : "sucesso"}
    
@app.post('/register')
async def register(request: Request):
    data = await request.json()
    email = data.get('email')
    nome = data.get('nome')
    senha = data.get('senha')
    tipo = data.get('tipo')

    if not email or not senha or not nome or not tipo:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST, 
            detail='Email, nome, senha e tipo são obrigatórios.'
        )

    resultado_cadastro = cadastro_professor(app.database, email, nome, senha, tipo)
    
    if resultado_cadastro.get("success"):
        return {'message': resultado_cadastro.get("message")} 
    else:
        raise HTTPException(
            status_code=status.HTTP_409_CONFLICT, 
            detail=resultado_cadastro.get("message", "Erro desconhecido durante o cadastro.")
        )

@app.post('/login', status_code=status.HTTP_200_OK)
async def login(request: Request):
    data = await request.json()
    print(data)
    email_professor = data['email']
    senha = data['password']

    print(f"Recebida tentativa de login para: {email_professor}")
    print(f"Senha fornecida: {senha}")

    if not email_professor or not senha:
        print("Erro: Email e senha são obrigatórios.")
        raise HTTPException(status_code= HTTP_406_NOT_ACCEPTABLE, detail='Email e senha são obrigatórios.')

    token, is_admin = autenticar_professor(app.database,email_professor, senha)
    if token is not None:
        print(f"Login bem-sucedido para: {email_professor}")
        return {'token': token, "is_admin" : is_admin}
    else:
        print(f"Falha no login para: {email_professor}")
        raise HTTPException(status_code= HTTP_401_UNAUTHORIZED ,detail='Credenciais inválidas.')
    
@app.get('/users', status_code=status.HTTP_200_OK)
async def list_users():
    try:
        usuarios_cursor = app.database["usuario"].find({}, {"_id": 0, "senha": 0}) 
        usuarios_list = list(usuarios_cursor)
        return usuarios_list
    except Exception as e:
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR, 
            detail=f"Erro ao buscar usuários no banco de dados: {str(e)}"
        )
        
@app.delete('/users/{email}')
async def delete_user(email:str):
    resultado_delecao = deletar_professor(app.database, email)
    
    if resultado_delecao.get("success"):
        return{"message": resultado_delecao.get("message")}
    else:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST, 
            detail=resultado_delecao.get("message", "Erro desconhecido na deleção.")
        )   
