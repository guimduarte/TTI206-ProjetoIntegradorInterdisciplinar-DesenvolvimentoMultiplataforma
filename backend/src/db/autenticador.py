# auth.py
from werkzeug.security import generate_password_hash, check_password_hash
from db.mongodb import db

def registrar_professor(email, senha, nome):
    if db.usuario.find_one({'email': email}):
        return "Erro: Já existe um usuário com esse email."

    novo_usuario = {
        'nome': nome,
        'email': email,
        'senhaHash': generate_password_hash(senha),
        'tipo': 'professor'
    }

    db.usuario.insert_one(novo_usuario)
    return "Professor registrado com sucesso."

def autenticar_professor(email, senha):
    usuario = db.usuario.find_one({'email': email})

    if usuario and check_password_hash(usuario['senhaHash'], senha):
        is_admin = usuario.get('tipo') == 'admin'
        return True, is_admin

    return False, False
