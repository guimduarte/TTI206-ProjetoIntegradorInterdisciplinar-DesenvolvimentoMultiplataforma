import 'dart:convert';
import 'package:http/http.dart' as http;

class ImageService {
  static const String _baseUrl = 'http://localhost:8000';

  Future<Map<String, dynamic>> updateImageDescription({
    required String imageName,
    required String newDescription,
  }) async {
    final url = Uri.parse('$_baseUrl/image-info/$imageName');
    try {
      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'description': newDescription}),
      );

      if (response.statusCode == 200) {
        return {"success": true, "message": "Descrição atualizada!"};
      } else {
        final body = jsonDecode(response.body);
        return {"error": true, "message": body['detail'] ?? "Erro ao atualizar"};
      }
    } catch (e) {
      return {"error": true, "message": "Erro de conexão: $e"};
    }
  }

  Future<Map<String, dynamic>> deleteImage({required String imageName}) async {
    final url = Uri.parse('$_baseUrl/image-info/$imageName');
    try {
      final response = await http.delete(url);

      if (response.statusCode == 200) {
        return {"success": true, "message": "Imagem deletada!"};
      } else {
        final body = jsonDecode(response.body);
        return {"error": true, "message": body['detail'] ?? "Erro ao deletar"};
      }
    } catch (e) {
      return {"error": true, "message": "Erro de conexão: $e"};
    }
  }
}