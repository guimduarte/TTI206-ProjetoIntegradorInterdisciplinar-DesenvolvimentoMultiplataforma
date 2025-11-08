from pymongo import MongoClient
import bcrypt
import datetime
import jwt
from datetime import date, timedelta, timezone, datetime
from dotenv import dotenv_values

config = dotenv_values(".env")
SECRET_KEY = config["SECRET_KEY"]
ALGORITHM = "HS256"
ACCESS_TOKEN_EXPIRE_MINUTES = 120

def verify_password(plain_password, hashed_password):
    return bcrypt.checkpw(
        plain_password.encode("utf-8"),
        hashed_password.encode("utf-8"),
    )

def get_password_hash(password):
    return bcrypt.hashpw(password.encode("utf-8"), bcrypt.gensalt()).decode("utf-8")

def create_access_token(data: dict, expires_delta: timedelta | None = None):
    to_encode = data.copy()
    if expires_delta:
        expire = datetime.now(timezone.utc) + expires_delta
    else:
        expire = datetime.now(timezone.utc) + timedelta(minutes=15)
    to_encode.update({"exp": expire})
    encoded_jwt = jwt.encode(to_encode, SECRET_KEY, algorithm=ALGORITHM)
    return encoded_jwt

def get_current_user(token: str, db):
    payload = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
    email = payload.get("email")
    if email is None:
        return None
    usuario = db.usuario.find_one({'email':email})
    if usuario is None:
        return None
    return usuario

def cadastro_professor(db, email,nome,senha):
    if db.usuario.find_one({'email':email}):
        return "Erro: Esse email já foi utilizado para cadastro"
    
    novo_usuario = {
        'nome': nome,
        'email': email,
        'senha': get_password_hash(senha),
        'tipo':'professor'
    }
    db.usuario.insert_one(novo_usuario)
    return "Professor registrado"

def autenticar_professor(db, email,senha):
    usuario = db.usuario.find_one({'email':email})
    if usuario and verify_password(senha, usuario['senha']):
        is_admin = usuario["tipo"] == 'admin'
        return create_access_token({"admin" : is_admin, "nome" : usuario["nome"], "email" : usuario["email"]}), is_admin
    return None, None
        
