import 'package:atlas_digital_fmabc/data/constants/constants.dart';
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
    final theme = Theme.of(context);
    // cores
    final railBackground = theme.colorScheme.onSecondaryFixed;
    final railForeground = theme.colorScheme.secondaryFixed;

    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth >= KBreakpoints.md;

        /// Índice selecionado no Navigation.
        final selectedIndex = widget.navigationShell.currentIndex;

        /// Widget de navegação lateral para desktop.
        final rail = NavigationRail(
          // style:
          labelType: NavigationRailLabelType.all, // exibir rótulos
          backgroundColor: railBackground,
          indicatorColor: theme.colorScheme.primary,
          // estilo de destinos não selecionados
          unselectedLabelTextStyle: TextStyle(color: railForeground),
          unselectedIconTheme: IconThemeData(color: railForeground),
          // estilo de destinos selecionados
          selectedLabelTextStyle: TextStyle(color: Colors.white),
          selectedIconTheme: IconThemeData(color: theme.colorScheme.onPrimary),

          selectedIndex: selectedIndex,
          // Lista de destinos
          destinations: destinations
              .map(
                (d) => NavigationRailDestination(
                  icon: Icon(d.icon),
                  selectedIcon: Icon(d.selectedIcon),
                  label: Text(d.label),
                ),
              )
              .toList(),
          // Função executada ao selecionar um destino
          onDestinationSelected: (int index) {
            if (index == MainLayout.menuIndex) {
              // Se selecionar menu, abrir o drawer
              _scaffoldKey.currentState?.openEndDrawer();
            } else {
              // Navegar para a branch selecionada
              widget.navigationShell.goBranch(index);
            }
          },
        );

        return Scaffold(
          key: _scaffoldKey, // Chave para controlar o Scaffold
          endDrawer: MenuDrawer(), // menu lateral aberto na direita
          // Corpo principal responsivo
          body: isDesktop
              ? Row(
                  children: [
                    // Navegação lateral
                    SafeArea(child: rail),
                    // Conteúdo da rota
                    Expanded(child: widget.navigationShell),
                  ],
                ) // desktop
              : widget.navigationShell, // mobile (apenas conteúdo)
          // Barra de navegação para mobile
          bottomNavigationBar: isDesktop
              ? null
              : NavigationBar(
                  selectedIndex: widget
                      .navigationShell
                      .currentIndex, // Índice da aba atual
                  onDestinationSelected: (int index) {
                    // Abrir drawer se for a aba de menu
                    if (index == MainLayout.menuIndex) {
                      _scaffoldKey.currentState?.openEndDrawer();
                    } else {
                      // navegar para a branch
                      widget.navigationShell.goBranch(
                        index,
                      ); // Função para mudar de aba
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
      },
    );
  }
}
