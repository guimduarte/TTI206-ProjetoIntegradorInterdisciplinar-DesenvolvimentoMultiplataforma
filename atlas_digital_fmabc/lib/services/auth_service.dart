import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';

class AuthService {
  static const String _baseUrl = 'http://localhost:8000';

  Future<Map<String, dynamic>> register({
    required String nome,
    required String email,
    required String senha,
    required String userType, // 'admin' ou 'professor'
  }) async {
    final url = Uri.parse('$_baseUrl/register');

    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'nome': nome,
          'email': email,
          'senha': senha,
          'tipo': userType,
        }),
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
      try {
              final responseBody = jsonDecode(response.body);
              final message = responseBody['message'] ?? "Registro bem-sucedido!";
              
              return {"success": true, "message": message}; 
          } catch (_) {
              return {"success": true, "message": "Registro concluído com sucesso."};
          }
      } else {
        try {
            final responseBody = jsonDecode(response.body);
            final errorMessage = responseBody['message'] ?? responseBody['detail'] ?? 'Ocorreu um erro no servidor. Status: ${response.statusCode}.';
            return {"error": true, "message": errorMessage};
        } catch (_) {
            return {"error": true, "message": "Erro no servidor. Status: ${response.statusCode}."};
        }
      }
    } on SocketException {
        return {"error": true, "message": "Erro de conexão: Não foi possível alcançar o servidor em localhost:8000."};
    } catch (e) {
        // Outros erros genéricos
        return {"error": true, "message": "Erro inesperado durante a comunicação. ($e)"};
    }
  }

  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    final url = Uri.parse('$_baseUrl/login');
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      String token = responseBody['token'] ?? 'MOCK_TOKEN_123';
      bool isAdmin = responseBody['is_admin'] ?? false;
      print('Login successful. Received token: $token $isAdmin');
      return {"token": token, "is_admin": isAdmin};
    } else {
      final responseBody = jsonDecode(response.body);
      return {"error": responseBody["detail"] ?? 'Falha no login'};
    }
  }

  Future<Map<String, dynamic>> deleteUser({required String email}) async {
    final url = Uri.parse('$_baseUrl/users/$email');
    
    try {
      final response = await http.delete(url);

      if (response.statusCode >= 200 && response.statusCode < 300) {
          String message = "Usuário deletado com sucesso!";
          try {
              final responseBody = jsonDecode(response.body);
              message = responseBody['message'] ?? message;
          } catch (_) {}
          
          return {"success": true, "message": message}; 
          
      } else {
        String errorMessage = "Falha ao deletar usuário. Status: ${response.statusCode}";
        try {
            final responseBody = jsonDecode(response.body);
            errorMessage = responseBody['detail'] ?? errorMessage;
        } catch (_) {}

        return {"error": true, "message": errorMessage};
      }
    } on SocketException {
        return {"error": true, "message": "Erro de conexão: Não foi possível alcançar o servidor."};
    } catch (e) {
        return {"error": true, "message": "Erro inesperado durante a deleção. ($e)"};
    }
  }



}



