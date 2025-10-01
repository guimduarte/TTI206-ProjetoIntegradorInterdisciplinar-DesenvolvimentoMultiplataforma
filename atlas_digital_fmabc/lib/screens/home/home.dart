import 'package:atlas_digital_fmabc/widgets/layout/mobile/app_navigation_bar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key}); // Construtor padrão

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // layout
      appBar: _homeAppBar(context),
      bottomNavigationBar: AppNavigationBar(selectedIndex: 0),
      // conteúdo
      body: Column(children: [Text("Página inicial")]),
    );
  }

  /// AppBar da página inicial.
  AppBar _homeAppBar(BuildContext context) {
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
