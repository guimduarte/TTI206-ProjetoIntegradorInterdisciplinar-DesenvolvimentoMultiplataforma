import 'package:http/http.dart' as http;

class UploadService {
  static const String _baseUrl = 'http://localhost:8000';

  Future<Map<String, dynamic>> uploadImage(
    String tarPath,
    String imageName,
    String imageDescription,
  ) async {
    final url = Uri.parse('$_baseUrl/image');
    final request = http.MultipartRequest("POST", url);
    request.files.add(await http.MultipartFile.fromPath("file", tarPath));
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
