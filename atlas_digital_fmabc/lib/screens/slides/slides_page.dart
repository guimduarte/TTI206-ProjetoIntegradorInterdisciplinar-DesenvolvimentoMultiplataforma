import 'package:flutter/material.dart';

/// Página de lâminas.
class SlidesPage extends StatelessWidget {
  const SlidesPage({super.key}); // Construtor padrão

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // layout
      appBar: _slidesAppBar(context),
      // conteúdo
      body: Column(children: [Text("Tópicos e lâminas")]),
    );
  }

  /// AppBar da página inicial.
  AppBar _slidesAppBar(BuildContext context) {
    final theme = Theme.of(context);
    return AppBar(
      // aparência
      backgroundColor: theme.colorScheme.primary,
      foregroundColor: theme.colorScheme.onPrimary,
      // título da página
      title: Text(
        "Explorar Lâminas",
        style: theme.textTheme.headlineMedium?.copyWith(
          color: theme.colorScheme.onPrimary,
        ),
      ),
      centerTitle: true,
    );
  }
}
