import 'package:flutter/material.dart';

class MenuDrawer extends StatefulWidget {
  const MenuDrawer({super.key});

  @override
  State<MenuDrawer> createState() => _MenuDrawerState();
}

class _MenuDrawerState extends State<MenuDrawer> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: NavigationDrawer(
        children: [
          NavigationDrawerDestination(
            icon: Icon(Icons.home),
            label: Text("Teste"),
          ),
          NavigationDrawerDestination(
            icon: Icon(Icons.home),
            label: Text("Teste"),
          ),
          NavigationDrawerDestination(
            icon: Icon(Icons.home),
            label: Text("Teste"),
          ),
          NavigationDrawerDestination(
            icon: Icon(Icons.home),
            label: Text("Teste"),
          ),
        ],
      ),
    );
  }
}
