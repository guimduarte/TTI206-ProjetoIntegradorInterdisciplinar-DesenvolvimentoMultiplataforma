import 'package:atlas_digital_fmabc/models/navigation/destination.dart';
import 'package:flutter/material.dart';

class MenuDrawer extends StatefulWidget {
  const MenuDrawer({super.key});

  @override
  State<MenuDrawer> createState() => _MenuDrawerState();
}

class _MenuDrawerState extends State<MenuDrawer> {
  /// Divisor das seções do menu.
  final _menuDivider = Divider(indent: 12, endIndent: 12);

  /// Título das seções do menu.
  Padding _sectionHeader(String title, ThemeData theme) => Padding(
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
    child: Text(
      title,
      style: theme.textTheme.titleSmall?.copyWith(
        color: theme.colorScheme.onSurfaceVariant,
      ),
    ),
  );

  /// Função que retorna uma lista de widgets [NavigationDrawerDestination]
  /// para cada seção do menu.
  Iterable<NavigationDrawerDestination> destinationsBuilder(
    List<Destination> destinations,
  ) {
    return destinations.map(
      (d) => NavigationDrawerDestination(
        icon: Icon(d.icon),
        selectedIcon: Icon(d.selectedIcon),
        label: Text(d.label),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: NavigationDrawer(
        children: [
          SizedBox(height: 12.0),

          // Seção Principal
          _sectionHeader("Menu", theme),
          ...destinationsBuilder(menuDestinations),
          _menuDivider,

          // Seção Contato
          _sectionHeader("Contato", theme),
          ...destinationsBuilder(contactDestinations),
          _menuDivider,

          // Seção do Administrador
          _sectionHeader("Área do Administrador", theme),
          ...destinationsBuilder(adminDestinations),
        ],
      ),
    );
  }
}
