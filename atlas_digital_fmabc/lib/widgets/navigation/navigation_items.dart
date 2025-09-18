import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

/// Lista de itens de navegação.
final List<NavigationDestination> navigationItems = [
  // Início
  NavigationDestination(icon: Icon(LucideIcons.home), label: "Início"),
  // Lâminas
  NavigationDestination(icon: Icon(LucideIcons.microscope), label: "Lâminas"),
  // Anotações
  NavigationDestination(icon: Icon(LucideIcons.book), label: "Anotações"),
  // Imagens salvas
  NavigationDestination(icon: Icon(LucideIcons.bookmark), label: "Salvos"),
];
