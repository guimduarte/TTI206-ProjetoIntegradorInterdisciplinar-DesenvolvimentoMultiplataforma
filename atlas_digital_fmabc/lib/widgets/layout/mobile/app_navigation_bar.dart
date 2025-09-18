import 'package:atlas_digital_fmabc/widgets/navigation/navigation_items.dart';
import 'package:flutter/material.dart';

/// Barra de navegação para dispositivos móveis.
class AppNavigationBar extends StatelessWidget {
  /// Índice do item atual.
  final int selectedIndex;

  /// Construtor
  const AppNavigationBar({super.key, this.selectedIndex = 0});

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      destinations: navigationItems,
      selectedIndex: selectedIndex, // item selecionado
    );
  }
}
