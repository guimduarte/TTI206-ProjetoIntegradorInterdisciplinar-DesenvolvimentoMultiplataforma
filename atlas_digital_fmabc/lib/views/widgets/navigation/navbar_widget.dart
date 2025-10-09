import 'package:atlas_digital_fmabc/data/notifiers.dart';
import 'package:atlas_digital_fmabc/views/widgets/navigation/navigation_items.dart';
import 'package:flutter/material.dart';

/// Barra de navegação para dispositivos móveis.
class NavbarWidget extends StatelessWidget {
  const NavbarWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: selectedPageNotifier,
      builder: (context, selectedPage, child) {
        return NavigationBar(
          destinations: navigationItems,
          onDestinationSelected: (int value) {
            selectedPageNotifier.value = value;
          },
          selectedIndex: selectedPage,
        );
      }
    );
  }
}
