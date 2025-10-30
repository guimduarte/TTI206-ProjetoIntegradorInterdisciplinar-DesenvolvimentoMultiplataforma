import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  static const String _baseUrl = 'mongodb://localhost:27017/'; 
  

  Future<String?> register({
    required String name,
    required String email, 
    required String password
  }) async {
    final url = Uri.parse('$_baseUrl/register');
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name':name,
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 201) {
      return 'Registration successful!';
    } else {
      final responseBody = jsonDecode(response.body);
      return responseBody['message'] ?? 'An unknown error occurred during registration.';
    }
  }


  Future<String?> login({
    required String email, 
    required String password
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
      final responseBody = jsonDecode(response.body);
      String token = responseBody['token'] ?? 'MOCK_TOKEN_123'; 
      print('Login successful. Received token: $token'); 
      return null; 
    } else {
      final responseBody = jsonDecode(response.body);
      return responseBody['message'] ?? 'Login failed. Please try again.';
    }
  }
}