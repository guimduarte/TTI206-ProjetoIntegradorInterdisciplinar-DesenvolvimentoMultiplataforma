/// Modelo de grupos de lâminas (temas, tópicos e turmas)
abstract class GroupModel {
  // Construtor
  GroupModel({required this.name, this.quantSlides = 0});

  // Atributos
  /// Nome do grupo.
  final String name;

  /// Quantidade de lâminas.
  int quantSlides;
}
