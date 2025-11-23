import 'package:atlas_digital_fmabc/config/routes/routes.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

/// Modelo para representar um destino de navegação.
class Destination {
  const Destination({
    required this.label,
    required this.icon,
    required this.selectedIcon,
    this.route,
  });

  /// Rótulo do destino.
  final String label;

  /// Ícone do destino não selecionado.
  final IconData icon;

  /// Ícone do destino selecionado.
  final IconData selectedIcon;

  /// Rota do destino.
  final String? route;
}

/// Lista dos destinos para as principais páginas do aplicativo.
const mainDestinations = [
  Destination(
    label: "Início",
    icon: FluentIcons.home_24_regular,
    selectedIcon: FluentIcons.home_24_filled,

    route: Routes.homePage,
  ),
  Destination(
    label: "Lâminas",
    icon: FluentIcons.microscope_24_regular,
    selectedIcon: FluentIcons.microscope_24_filled,

    route: Routes.slidesPage,
  ),
  Destination(
    label: "Salvos",
    icon: FluentIcons.bookmark_24_regular,
    selectedIcon: FluentIcons.bookmark_24_filled,

    route: Routes.savedItens,
  ),
  Destination(
    label: "Menu",
    icon: FluentIcons.navigation_24_regular,
    selectedIcon: FluentIcons.navigation_24_filled,
  ),
];

/// Destinos para o menu lateral.
final railDestinations = [
  ...mainDestinations.sublist(0, 3),
  const Destination(
    label: "Pesquisar",
    icon: FluentIcons.search_24_regular,
    selectedIcon: FluentIcons.search_24_regular,
  ),
];

/// Destinos para a área do administrador.
final adminDestinations = [
  Destination(
    label: "Entrar como Professor",
    icon: FluentIcons.arrow_enter_20_regular,
    selectedIcon: FluentIcons.arrow_enter_20_filled,

    route: Routes.nestedLoginPage,
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
    label: "Fale Conosco",
    icon: FluentIcons.call_24_regular,
    selectedIcon: FluentIcons.call_24_filled,

    route:Routes.contatoPage
  ),

];

const testeDestinations = [
  Destination(
    label: "Teste",
    icon: FluentIcons.alert_24_regular,
    selectedIcon: FluentIcons.alert_24_filled,
    route: Routes.nestedImagemPage
)];
