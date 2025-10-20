from contextlib import asynccontextmanager
from os import stat
from typing import Annotated
from fastapi import FastAPI, HTTPException, Path, Request, Response, UploadFile, status
import json
from dotenv import dotenv_values
import tempfile
from src.db.image import ImageDB
from pymongo import MongoClient
from src.image import generate_image, decompress_file

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

def getDatabase(collection_name : str):
    return app.database[collection_name]

@app.get("/")
async def root():
    return {"message": "Hello World"}

@app.post("/image", status_code=status.HTTP_201_CREATED)
async def upload_image(file: UploadFile):
    image_directory = decompress_file(file)
    result = generate_image(image_directory)
    if not result:
        raise HTTPException(status_code=status.HTTP_412_PRECONDITION_FAILED, detail="Houve um erro ao tentar criar a imagem")
    return {"message" : "sucesso"}


@app.get("/image/{image_name}/{x}/{y}/{z}")
async def get_image(image_name : Annotated[str, Path()], x : Annotated[int, Path()],
                    y : Annotated[int, Path()], z : Annotated[int, Path()]):
    imagedb = ImageDB(image_name, getDatabase(ImageDB.collection_name))
    file = imagedb.get_image(f"{x}/{y}/{z}")
    return Response(file)
