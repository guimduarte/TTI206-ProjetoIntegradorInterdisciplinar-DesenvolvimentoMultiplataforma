import 'package:atlas_digital_fmabc/models/navigation/destination.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Layout principal do aplicativo.
/// Usado para garantir estrutura consistente e responsiva.
class MainLayout extends StatelessWidget {
  const MainLayout({super.key, required this.navigationShell});

  /// Instância do StatefulNavigationShell para gerenciar navegação.
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    // Layout para mobile
    return Scaffold(
      body: navigationShell, // Corpo principal gerenciado pelo NavigationShell
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex, // Índice da aba atual
        onDestinationSelected:
            navigationShell.goBranch, // Função para mudar de aba
        // Lista de destinos
        destinations: destinations
            .map(
              // Montar widget de destino
              (destination) => NavigationDestination(
                label: destination.label,
                icon: Icon(destination.icon),
                selectedIcon: Icon(destination.selectedIcon),
              ),
            )
            .toList(),
      ),
    );
  }
}
