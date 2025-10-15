class CategoriaModel {
  late String nomeCategoria;
  late String imagemCapa;
  late List<String> imagens;

  CategoriaModel(this.nomeCategoria, this.imagemCapa, this.imagens);

  @override
  String toString() {
    return 'nome: $nomeCategoria, imagens: $imagens';
  }
}