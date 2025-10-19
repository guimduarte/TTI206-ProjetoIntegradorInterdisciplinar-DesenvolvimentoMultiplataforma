# Falta ligação com um banco em si. so criar
# 

@app.route('/register', methods=['POST'])
def register():
    data = request.json
    email_professor = data.get('email_professor')
    nome = data.get('nome_professor')
    senha = data.get('senha')

    if not email_professor or not senha or not nome:
        return jsonify({'success': False, 'message': 'Email, nome e senha são obrigatórios.'}), 400

    mensagem = registrar_professor(email_professor, senha)
    if "sucesso" in mensagem.lower():
        return jsonify({'success': True, 'message': mensagem}), 201
    else:
        return jsonify({'success': False, 'message': mensagem}), 400

@app.route('/login', methods=['OPTIONS'])
def handle_login_options():
    """Handles OPTIONS requests for /login."""
    response = jsonify()
    response.headers.add('Access-Control-Allow-Origin', '*')
    response.headers.add('Access-Control-Allow-Methods', 'POST, OPTIONS')
    response.headers.add('Access-Control-Allow-Headers', 'Content-Type')
    return response

@app.route('/login', methods=['POST'])
def login():
    data = request.json
    email_professor = data.get('email_professor')
    senha = data.get('senha')

    print(f"Recebida tentativa de login para: {email_professor}")
    print(f"Senha fornecida: {senha}")

    if not email_professor or not senha:
        print("Erro: Email e senha são obrigatórios.")
        return jsonify({'success': False, 'message': 'Email e senha são obrigatórios.'}), 400

    senha_correta, is_admin = autenticar_professor(email_professor, senha)
    if senha_correta:
        print(f"Login bem-sucedido para: {email_professor}, isAdmin: {is_admin}")
        return jsonify({'success': True, 'message': 'Login realizado com sucesso!', 'numero_cliente': email_professor, 'is_admin': is_admin}), 200
    else:
        print(f"Falha no login para: {email_professor}")
        return jsonify({'success': False, 'message': 'Credenciais inválidas.'}), 401
