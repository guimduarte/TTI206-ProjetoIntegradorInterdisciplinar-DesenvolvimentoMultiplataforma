import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

class AppNavigationBar extends StatefulWidget {
  const AppNavigationBar({super.key});

  @override
  State<AppNavigationBar> createState() => _AppNavigationBarState();
}

class _AppNavigationBarState extends State<AppNavigationBar> {
  /// Lista de destinos da NavigationBar.
  final List<NavigationDestination> _destinations = [
    // Início
    NavigationDestination(
      icon: Icon(FluentIcons.home_24_regular),
      selectedIcon: Icon(FluentIcons.home_24_filled),
      label: "Início",
    ),
    // Lâminas
    NavigationDestination(
      icon: Icon(FluentIcons.microscope_24_regular),
      selectedIcon: Icon(FluentIcons.microscope_24_filled),
      label: "Lâminas",
    ),
    // Salvos
    NavigationDestination(
      icon: Icon(FluentIcons.bookmark_24_regular),
      selectedIcon: Icon(FluentIcons.bookmark_24_filled),
      label: "Salvos",
    ),
    // Menu
    NavigationDestination(
      icon: Icon(FluentIcons.navigation_24_regular),
      selectedIcon: Icon(FluentIcons.navigation_24_filled),
      label: "Menu",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return NavigationBar(destinations: _destinations);
  }
}
