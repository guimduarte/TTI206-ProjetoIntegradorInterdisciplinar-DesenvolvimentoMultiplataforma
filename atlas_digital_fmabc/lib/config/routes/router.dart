import 'package:atlas_digital_fmabc/config/routes/routes.dart';
import 'package:atlas_digital_fmabc/screens/home/home_page.dart';
import 'package:atlas_digital_fmabc/screens/saved_itens/saved_itens.dart';
import 'package:atlas_digital_fmabc/screens/slides/slides_page.dart';
import 'package:atlas_digital_fmabc/widgets/layout/main_layout.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Chave do navegador raiz.
final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: "root");

/// Configuração do roteador usando GoRouter.
final router = GoRouter(
  navigatorKey: _rootNavigatorKey, // chave do navegador raiz
  initialLocation: Routes.homePage, // rota inicial
  // Lista de rotas
  routes: [
    StatefulShellRoute.indexedStack(
      // Rota raiz com abas de navegação
      builder: (context, state, navigationShell) =>
          MainLayout(navigationShell: navigationShell),
      // Definição das abas
      branches: [
        // Início
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.homePage, // caminho/endpoint
              builder: (context, state) => const HomePage(), // widget da página
            ),
          ],
        ),
        // Lâminas
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.slidesPage,
              builder: (context, state) => const SlidesPage(),
            ),
          ],
        ),
        // Salvos
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.savedItens,
              builder: (context, state) => const SavedItens(),
            ),
          ],
        ),
        // Menu
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.menuPage,
              builder: (context, state) => const SizedBox.shrink(),
            ),
          ],
        ),
      ],
    ),
  ],
);
