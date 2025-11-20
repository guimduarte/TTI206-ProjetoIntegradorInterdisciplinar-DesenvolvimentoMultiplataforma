import 'dart:convert';
import 'package:atlas_digital_fmabc/models/groups/group_model.dart';
import 'package:atlas_digital_fmabc/models/groups/theme_model.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

class CategoryService {
  static const String _baseUrl = 'http://localhost:8000';

  Future<List<GroupModel>> getCategories() async {
    final url = Uri.parse('$_baseUrl/categories');

    try {
      final response = await http.get(url);
      final responseBody = jsonDecode(response.body);
      final categories = responseBody['categories'];
      List<GroupModel> groups = [];
      for (var category in categories) {
        groups.add(ThemeModel.fromJson(category));
      }
      return groups;
    } catch (e) {
      print(e.toString());
    }
    return [];
  }
}
