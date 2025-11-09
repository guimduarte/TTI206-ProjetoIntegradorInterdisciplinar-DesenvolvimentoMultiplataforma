import 'package:atlas_digital_fmabc/config/routes/routes.dart';
import 'package:atlas_digital_fmabc/screens/admin/auth/login_page.dart';
import 'package:atlas_digital_fmabc/screens/home/home_page.dart';
import 'package:atlas_digital_fmabc/screens/imagem_teste/imagem_teste.dart';
import 'package:atlas_digital_fmabc/screens/saved_itens/saved_itens.dart';
import 'package:atlas_digital_fmabc/screens/slides/explore_slides_page.dart';
import 'package:atlas_digital_fmabc/common/widgets/layout/main_layout.dart';
import 'package:atlas_digital_fmabc/screens/professor_area/professor_area.dart'; // ✅ importa a tela do professor
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Chave do navegador raiz.
final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: "root");

/// Configuração do roteador usando GoRouter.
final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: Routes.homePage,
  routes: [
    // 🔹 Rota fora das abas — tela do professor
    GoRoute(
      path: '/professorArea',
      builder: (context, state) => const ProfessorArea(),
    ),

    // 🔹 Estrutura principal com abas
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          MainLayout(navigationShell: navigationShell),
      branches: [
        // Início
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.homePage,
              builder: (context, state) => const HomePage(),
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
        // Menu e subpáginas
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.menuPage,
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
                GoRoute(
                  path: Routes.imagemTeste,
                  builder: (context, state) => const TesteImagem(),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);
