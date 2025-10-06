import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

/// Modelo para representar um destino de navegação.
class Destination {
  const Destination({
    required this.label,
    required this.icon,
    required this.selectedIcon,
  });

  /// Rótulo do destino.
  final String label;

  /// Ícone do destino não selecionado.
  final IconData icon;

  /// Ícone do destino selecionado.
  final IconData selectedIcon;
}

/// Lista dos destinos para as principais páginas do aplicativo.
const destinations = [
  Destination(
    label: "Início",
    icon: FluentIcons.home_24_regular,
    selectedIcon: FluentIcons.home_24_filled,
  ),
  Destination(
    label: "Lâminas",
    icon: FluentIcons.microscope_24_regular,
    selectedIcon: FluentIcons.microscope_24_filled,
  ),
  Destination(
    label: "Salvos",
    icon: FluentIcons.bookmark_24_regular,
    selectedIcon: FluentIcons.bookmark_24_filled,
  ),
  Destination(
    label: "Menu",
    icon: FluentIcons.navigation_24_regular,
    selectedIcon: FluentIcons.navigation_24_filled,
  ),
];
