import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';

class CategoryService {
  static const String _baseUrl = 'http://localhost:8000'; 

  Future<Map<String, dynamic>> fetchCategories() async {
    final url = Uri.parse('$_baseUrl/categories');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return {"success": true, "data": jsonList};
      } else {
        final responseBody = jsonDecode(response.body);
        final errorMessage = responseBody['detail'] ?? 'Falha ao buscar categorias. Status: ${response.statusCode}';
        return {"error": true, "message": errorMessage};
      }
    } on SocketException {
      return {"error": true, "message": "Erro de conexão: Servidor de categorias inacessível."};
    } catch (e) {
      return {"error": true, "message": "Erro inesperado ao listar categorias. ($e)"};
    }
  }

  Future<Map<String, dynamic>> createCategory({required String categoryName}) async {
    final url = Uri.parse('$_baseUrl/categories');
    
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode({'category_name': categoryName, 'images': []}),
      );

      if (response.statusCode == 201) { 
        return {"success": true, "message": "Categoria criada com sucesso!"};
      } else {
        final responseBody = jsonDecode(response.body);
        final errorMessage = responseBody['detail'] ?? 'Erro ao criar categoria. Status: ${response.statusCode}';
        return {"error": true, "message": errorMessage};
      }
    } on SocketException {
      return {"error": true, "message": "Erro de conexão: Servidor de categorias inacessível."};
    } catch (e) {
      return {"error": true, "message": "Erro inesperado ao criar categoria. ($e)"};
    }
  }

  Future<Map<String, dynamic>> deleteCategory({required String categoryName}) async {
    final url = Uri.parse('$_baseUrl/categories/$categoryName');
    
    try {
      final response = await http.delete(url);

      if (response.statusCode == 200) { 
        return {"success": true, "message": "Categoria deletada com sucesso."};
      } else {
        final responseBody = jsonDecode(response.body);
        final errorMessage = responseBody['detail'] ?? 'Falha ao deletar categoria. Status: ${response.statusCode}';
        return {"error": true, "message": errorMessage};
      }
    } on SocketException {
      return {"error": true, "message": "Erro de conexão: Servidor de categorias inacessível."};
    } catch (e) {
      return {"error": true, "message": "Erro inesperado ao deletar categoria. ($e)"};
    }
  }
  
  Future<Map<String, dynamic>> updateCategory({
    required String oldName,
    String? newName, 
    List<String>? newImages, 
  }) async {
    final url = Uri.parse('$_baseUrl/categories/$oldName');
    
    Map<String, dynamic> body = {};
    if (newName != null) body['new_name'] = newName;
    if (newImages != null) body['new_images'] = newImages;

    if (body.isEmpty) {
        return {"error": true, "message": "Nenhum dado de atualização fornecido."};
    }
    
    try {
      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
          return {"success": true, "message": "Categoria atualizada com sucesso!"};
      } else {
        final responseBody = jsonDecode(response.body);
        final errorMessage = responseBody['detail'] ?? 'Falha ao atualizar categoria. Status: ${response.statusCode}';
        return {"error": true, "message": errorMessage};
      }
    } on SocketException {
        return {"error": true, "message": "Erro de conexão: Servidor de categorias inacessível."};
    } catch (e) {
        return {"error": true, "message": "Erro inesperado durante a atualização. ($e)"};
    }
  }

    Future<Map<String, dynamic>> fetchAvailableImages() async {
    final url = Uri.parse('$_baseUrl/images_list'); 
    
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        return {"success": true, "data": responseBody['images']};
      } else {
        final responseBody = json.decode(response.body);
        final errorMessage = responseBody['detail'] ?? 'Falha ao buscar lista de imagens.';
        return {"error": true, "message": errorMessage};
      }
    } on SocketException {
      return {"error": true, "message": "Erro de conexão ao buscar imagens."};
    } catch (e) {
      return {"error": true, "message": "Erro inesperado ao listar imagens. ($e)"};
    }
  }


}