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
      return 'Registration successful!';
    } else {
      final responseBody = jsonDecode(response.body);
      return responseBody['message'] ??
          'An unknown error occurred during registration.';
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
      return {"error" : responseBody["detail"]};
    }
  }
}
