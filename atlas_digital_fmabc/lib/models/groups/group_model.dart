import 'package:atlas_digital_fmabc/models/image_model.dart';

/// Modelo de grupos de lâminas (temas, tópicos e turmas)
abstract class GroupModel {
  // Construtor
  GroupModel({required this.id, required this.name, this.quantSlides = 0, required this.listaDeImagens});

  // Atributos
  // id
  final String id;
  
  /// Nome do grupo.
  final String name;

  /// Quantidade de lâminas.
  int quantSlides;

  List<ImageModel> listaDeImagens;
}
