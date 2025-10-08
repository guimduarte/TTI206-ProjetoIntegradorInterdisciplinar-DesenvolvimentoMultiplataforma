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
const mobileDestinations = [
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

/// Destinos para o menu lateral.
final menuDestinations = [
  ...mobileDestinations.sublist(0, 3),
  const Destination(
    label: "Pesquisar",
    icon: FluentIcons.search_24_regular,
    selectedIcon: FluentIcons.search_24_regular,
  ),
  const Destination(
    label: "Sobre nós",
    icon: FluentIcons.info_24_regular,
    selectedIcon: FluentIcons.info_24_filled,
  ),
];

/// Destinos para a área do administrador.
const adminDestinations = [
  Destination(
    label: "Entrar como Professor",
    icon: FluentIcons.arrow_enter_20_regular,
    selectedIcon: FluentIcons.arrow_enter_20_filled,
  ),
];

/// Destinos de contato.
const contactDestinations = [
  Destination(
    label: "Site da FMABC",
    icon: FluentIcons.globe_24_regular,
    selectedIcon: FluentIcons.globe_24_filled,
  ),
  Destination(
    label: "E-mail",
    icon: FluentIcons.mail_24_regular,
    selectedIcon: FluentIcons.mail_24_filled,
  ),
  Destination(
    label: "Telefone",
    icon: FluentIcons.call_24_regular,
    selectedIcon: FluentIcons.call_24_filled,
  ),
];
