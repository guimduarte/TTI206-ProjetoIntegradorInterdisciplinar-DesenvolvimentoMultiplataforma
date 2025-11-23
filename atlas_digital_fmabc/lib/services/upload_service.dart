import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;

class UploadService {
  static const String _baseUrl = 'http://localhost:8000';

  Future<Map<String, dynamic>> uploadImage(
    String directoryPath,
    String imageName,
    String imageDescription,
  ) async {
    final url = Uri.parse('$_baseUrl/image');
    final request = http.MultipartRequest("POST", url);
    final directory = Directory(directoryPath);
    await for (final entity in directory.list(recursive: true)) {
      if (entity is File) {
        print(entity.path);
        request.files.add(
          await http.MultipartFile.fromPath("files", entity.path),
        );
      }
    }
    for (var item in request.files) {
      print(item.field);
      print(item.filename);
    }
    request.fields["image_name"] = imageName;
    request.fields["image_description"] = imageDescription;
    try {
      var response = await request.send();
      if (response.statusCode == 200) print('Uploaded!');
      return response.headers;
    } catch (e) {
      print("Houve um erro ao enviar");
      return {"Erro": e.toString()};
    }
  }
}
