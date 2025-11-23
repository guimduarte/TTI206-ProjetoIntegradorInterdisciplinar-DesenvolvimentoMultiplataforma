import 'package:atlas_digital_fmabc/models/image_model.dart';
import 'package:atlas_digital_fmabc/services/category_service.dart';
import 'package:atlas_digital_fmabc/widgets/lists/image_list.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Página de itens salvos.
class SavedItens extends StatelessWidget {
  const SavedItens({super.key}); // Construtor padrão

  Future<List<ImageModel>?> getSavedItens() async {
    CategoryService categoryService = CategoryService();
    final SharedPreferencesAsync asyncPrefs = SharedPreferencesAsync();
    var savedImageNames = await asyncPrefs.getStringList("savedItens");
    print(savedImageNames);
    if (savedImageNames == null) {
      return [];
    }
    final imageList = <ImageModel>[];
    final imageNames = <String>{};
    final categories = await categoryService.getCategories();
    for (var category in categories) {
      for (var image in category.listaDeImagens) {
        if (savedImageNames.contains(image.nome) &&
            !imageNames.contains(image.nome)) {
          imageList.add(image);
          imageNames.add(image.nome);
        }
      }
    }
    return imageList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // layout
      appBar: _savedAppBar(context),
      // conteúdo
      body: FutureBuilder(
        future: getSavedItens(),
        builder: (context, asyncSnapshot) {
          if (asyncSnapshot.hasData) {
            final images = asyncSnapshot.data;
            if (images!.isEmpty) {
              return Text("Não há imagens salvas ainda");
            }
            return Expanded(
              child: ImageList(listaDeImagens: asyncSnapshot.data!),
            );
          } else if (asyncSnapshot.hasError) {
            return Text(asyncSnapshot.error.toString());
          } else {
            return Text("Carregando");
          }
        },
      ),
    );
  }

  /// AppBar da página inicial.
  AppBar _savedAppBar(BuildContext context) {
    final theme = Theme.of(context);
    return AppBar(
      // aparência
      backgroundColor: theme.colorScheme.primary,
      foregroundColor: theme.colorScheme.onPrimary,
      // título da página
      title: Text(
        "Itens Salvos",
        style: theme.textTheme.headlineMedium?.copyWith(
          color: theme.colorScheme.onPrimary,
        ),
      ),
      centerTitle: true,
    );
  }
}
