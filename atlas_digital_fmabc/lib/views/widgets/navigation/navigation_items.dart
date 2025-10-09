import 'package:flutter/material.dart';


/// Lista de itens de navegação.
final List<NavigationDestination> navigationItems = [
  // Início
  NavigationDestination(
    icon: Icon(Icons.category),
    label: "Categorias",
  ),
  // Lâminas
  NavigationDestination(
    icon: Icon(Icons.group),
    label: "Turmas",
  ),
  // Itens salvos
  NavigationDestination(
    icon: Icon(Icons.access_time),
    label: "Mais Recentes",
  ),
];
