from contextlib import asynccontextmanager
from os import stat
from fastapi import FastAPI, HTTPException, Request, Response, UploadFile, status
import json
from dotenv import dotenv_values
from pymongo import MongoClient
from src.image import generate_image, decompress_file

config = dotenv_values(".env")


# @asynccontextmanager
# async def lifespan(app: FastAPI):
#     # on startup
#     app.mongodb_client = MongoClient(config["ATLAS_URI"])
#     app.database = app.mongodb_client[config["DB_NAME"]]
#     yield
#     # on shutdown
#     app.mongodb_client.close()
    
# app = FastAPI(lifespan=lifespan)
app = FastAPI()
    
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


@app.get("/image")
async def get_image(request : Request):
    request_json = await request.json()
    body = request_json["body"]
    print(body)
    
