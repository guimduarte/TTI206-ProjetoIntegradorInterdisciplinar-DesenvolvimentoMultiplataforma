import 'package:atlas_digital_fmabc/config/routes/routes.dart';
import 'package:atlas_digital_fmabc/screens/admin/auth/login_page.dart';
import 'package:atlas_digital_fmabc/screens/home/home_page.dart';
import 'package:atlas_digital_fmabc/screens/saved_itens/saved_itens.dart';
import 'package:atlas_digital_fmabc/screens/slides/explore_slides_page.dart';
import 'package:atlas_digital_fmabc/common/widgets/layout/main_layout.dart';
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
              builder: (context, state) => ExploreSlidesPage(),
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
              // redirecionar pro início
              redirect: (context, state) {
                if (state.fullPath == Routes.menuPage) {
                  return Routes.homePage;
                }
                return null;
              },
              routes: [
                GoRoute(
                  path: Routes.loginPage,
                  builder: (context, state) => const LoginPage(),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);
