import 'package:atlas_digital_fmabc/models/categoria_model.dart';
import 'package:atlas_digital_fmabc/views/pages/pagina_principal.dart';
import 'package:atlas_digital_fmabc/views/widgets/navigation/navbar_widget.dart';
import 'package:flutter/material.dart';

List<CategoriaModel> teste = [
  CategoriaModel('Categoria1', '', []),
  CategoriaModel('Categoria2', '', []),
  CategoriaModel('Categoria3', '', []),
  CategoriaModel('Categoria4', '', []),
  CategoriaModel('Categoria5', '', []),
  CategoriaModel('Categoria6', '', []),
  CategoriaModel('Categoria7', '', []),
  ];

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key}); // Construtor padrão

  @override
  Widget build(BuildContext context) {
    return PaginaPrincipal(categoriasLista: teste);
  }
}
