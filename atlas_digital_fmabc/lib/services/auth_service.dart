import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  static const String _baseUrl = 'http://localhost:8000';

  Future<String?> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final url = Uri.parse('$_baseUrl/register');
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': name,
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 201) {
      return null; // sem erro
    } else {
      try {
        final responseBody = jsonDecode(response.body);
        return responseBody['message'] ?? 'Erro no cadastro.';
      } catch (_) {
        return 'Erro no cadastro (sem mensagem do servidor).';
      }
    }
  }

  Future<String?> login({
    required String email,
    required String password,
  }) async {
    final url = Uri.parse('$_baseUrl/login');
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      // backend costuma devolver { "success": true, ... }
      try {
        final responseBody = jsonDecode(response.body);
        // log para debugging
        print('AuthService.login -> responseBody: $responseBody');

        // Se existir chave 'success' e for true, login OK
        if (responseBody is Map && (responseBody['success'] == true)) {
          return null; // sucesso
        }

        // às vezes backend retorna 200 mas com success=false
        return responseBody['message'] ?? 'Login falhou';
      } catch (e) {
        // se não for JSON mas deu 200, considera ok (fallback)
        print('AuthService.login -> parse error: $e');
        return null;
      }
    } else {
      try {
        final responseBody = jsonDecode(response.body);
        return responseBody['detail'] ?? responseBody['message'] ?? 'Erro no login';
      } catch (_) {
        return 'Erro de conexão com o servidor.';
      }
    }
  }
}
