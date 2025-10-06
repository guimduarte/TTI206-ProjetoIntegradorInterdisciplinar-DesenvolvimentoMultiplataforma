import 'package:flutter/material.dart';

/// Menu de opções para mobile.
class MenuPage extends StatelessWidget {
  const MenuPage({super.key}); // Construtor padrão

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // layout
      appBar: _menuAppBar(context),
      // conteúdo
      body: Column(children: [Text("Menu da aplicação")]),
    );
  }

  /// AppBar da página inicial.
  AppBar _menuAppBar(BuildContext context) {
    final theme = Theme.of(context);
    return AppBar(
      // aparência
      backgroundColor: theme.colorScheme.primary,
      foregroundColor: theme.colorScheme.onPrimary,
      // título da página
      title: Text(
        "Atlas Digital",
        style: theme.textTheme.headlineMedium?.copyWith(
          color: theme.colorScheme.onPrimary,
        ),
      ),
      centerTitle: true,
    );
  }
}
