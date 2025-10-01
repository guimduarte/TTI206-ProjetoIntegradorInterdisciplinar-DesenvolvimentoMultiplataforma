import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

/// Lista de itens de navegação.
final List<NavigationDestination> navigationItems = [
  // Início
  NavigationDestination(
    icon: Icon(FluentIcons.home_32_regular),
    selectedIcon: Icon(FluentIcons.home_32_filled),
    label: "Início",
  ),
  // Lâminas
  NavigationDestination(
    icon: Icon(FluentIcons.microscope_32_regular),
    selectedIcon: Icon(FluentIcons.microscope_32_filled),
    label: "Lâminas",
  ),
  // Itens salvos
  NavigationDestination(
    icon: Icon(FluentIcons.bookmark_32_regular),
    selectedIcon: Icon(FluentIcons.bookmark_32_filled),
    label: "Salvos",
  ),
  // Menu
  NavigationDestination(
    icon: Icon(FluentIcons.more_horizontal_32_regular),
    selectedIcon: Icon(FluentIcons.more_horizontal_32_filled),
    label: "Menu",
  ),
];
