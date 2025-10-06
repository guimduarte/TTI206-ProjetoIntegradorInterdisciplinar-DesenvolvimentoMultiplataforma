import 'package:atlas_digital_fmabc/widgets/navigation/app_navigation_bar.dart';
import 'package:flutter/material.dart';

/// Página de itens salvos.
class SavedItens extends StatelessWidget {
  const SavedItens({super.key}); // Construtor padrão

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // layout
      appBar: _savedAppBar(context),
      bottomNavigationBar: AppNavigationBar(currentIndex: 2),
      // conteúdo
      body: Column(children: [Text("Tópicos, lâminas e anotações salvas")]),
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
