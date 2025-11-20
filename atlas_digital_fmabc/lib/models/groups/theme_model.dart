import 'package:atlas_digital_fmabc/models/groups/group_model.dart';
import 'package:atlas_digital_fmabc/models/image_model.dart';

/// Modelo de dados dos temas das lâminas.
class ThemeModel extends GroupModel {
  // Construtor
  ThemeModel({
    required super.id,
    required super.name,
    super.quantSlides,
    required super.listaDeImagens,
  });
  static ThemeModel fromJson(Map<String, dynamic> decodedJson) {
    final id = decodedJson["_id"];
    final name = decodedJson["category_name"];
    final List<ImageModel> images = ImageModel.fromJson(decodedJson["images"]);
    final quantSlides = images.length;
    return ThemeModel(
      id: id,
      name: name,
      quantSlides: quantSlides,
      listaDeImagens: images,
    );
  }
}
