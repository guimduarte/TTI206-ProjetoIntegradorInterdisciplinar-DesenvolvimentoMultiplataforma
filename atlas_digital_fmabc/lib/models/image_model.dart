//EM FASE DE TESTE
import 'dart:convert';

class ImageModel {
  ImageModel({
    required this.id,
    required this.nome,
    required this.url,
    required this.descricao,
  });

  String id;
  String nome;
  String url;
  String descricao;

  static List<ImageModel> fromJson(List<dynamic> images) {
    List<ImageModel> imagesModel = [];
    for (final image in images) {
      imagesModel.add(
        ImageModel(
          id: image["_id"],
          nome: image["image_name"],
          descricao: image["image_description"],
          url: image["thumbnail"], // Recebe como base64
        ),
      );
    }
    return imagesModel;
  }
}
