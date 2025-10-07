import 'package:atlas_digital_fmabc/models/navigation/destination.dart';
import 'package:atlas_digital_fmabc/screens/menu/menu_drawer.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Layout principal do aplicativo.
/// Usado para garantir estrutura consistente e responsiva.
class MainLayout extends StatefulWidget {
  const MainLayout({super.key, required this.navigationShell});

  /// Instância do StatefulNavigationShell para gerenciar navegação.
  final StatefulNavigationShell navigationShell;

  /// Índice da aba "Menu" (se selecionado, irá abrir um drawer em vez de uma página).
  static const int menuIndex = 3;

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  /// Chave para controlar o Scaffold.
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    // Layout para mobile
    return Scaffold(
      key: _scaffoldKey, // Chave para controlar o Scaffold

      body: widget
          .navigationShell, // Corpo principal gerenciado pelo NavigationShell

      endDrawer: MenuDrawer(), // menu lateral aberto na direita

      bottomNavigationBar: NavigationBar(
        selectedIndex:
            widget.navigationShell.currentIndex, // Índice da aba atual
        onDestinationSelected: (int index) {
          // Abrir drawer se for a aba de menu
          if (index == MainLayout.menuIndex) {
            _scaffoldKey.currentState?.openEndDrawer();
          } else {
            // navegar para a branch
            widget.navigationShell.goBranch(index); // Função para mudar de aba
          }
        },
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
