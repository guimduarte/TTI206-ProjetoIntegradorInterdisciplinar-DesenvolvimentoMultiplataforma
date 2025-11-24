import 'package:atlas_digital_fmabc/config/routes/routes.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Página inicial.
class HomePage extends StatefulWidget {
  const HomePage({super.key}); 
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final TextEditingController _searchController = TextEditingController();
  void _submitSearch() {
    final text = _searchController.text.trim();
    if (text.isEmpty) return;

    // redirecionar para tela de busca
    context.go(
      Routes.slidesPage,
      extra: text, // mandando o texto para a outra página
    );
  }
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
     return Scaffold(
      appBar: _homeAppBar(context),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth >= 800; // breakpoint desktop

            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Search Bar
                  Center(
                    child: SizedBox(
                      width: isWide ? 600 : double.infinity,
                      child: SearchBar(
                        controller: _searchController,
                        hintText: "Pesquisar lâminas",
                        onSubmitted: (_) => _submitSearch(),
                        trailing: [
                          IconButton(
                            icon: Icon(FluentIcons.search_24_filled),
                            onPressed: () => _submitSearch,
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),

                  // ---------------------------------------------------------
                  // TEXTO DE APRESENTAÇÃO
                  // ---------------------------------------------------------
                  Text(
                    "Bem-vindo ao Atlas Digital FMABC",
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),

                  Text(
                    "Explore lâminas histológicas e patológicas digitalizadas. "
                    "Use a busca acima para encontrar estruturas específicas ou "
                    "navegue pelos atalhos abaixo.",
                    style: theme.textTheme.bodyLarge,
                  ),

                  const SizedBox(height: 32),

                  // ---------------------------------------------------------
                  // TRÊS BOTÕES PRINCIPAIS (Categorias / Turmas / Salvos)
                  // ---------------------------------------------------------
                  Text(
                    "Navegação rápida",
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16),

                  isWide
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(child: _homeButton(context, "Categorias", Icons.grid_view, Routes.slidesPage)),
                            const SizedBox(width: 20),
                            Expanded(child: _homeButton(context, "Turmas", Icons.school, Routes.slidesPage)),
                            const SizedBox(width: 20),
                            Expanded(child: _homeButton(context, "Salvos", Icons.bookmark, Routes.savedItens)),
                          ],
                        )
                      : Column(
                          children: [
                            _homeButton(context, "Categorias", Icons.grid_view, Routes.slidesPage),
                            const SizedBox(height: 16),
                            _homeButton(context, "Turmas", Icons.school, Routes.slidesPage),
                            const SizedBox(height: 16),
                            _homeButton(context, "Salvos", Icons.bookmark, Routes.savedItens),
                          ],
                        ),

                  const SizedBox(height: 40),

                  // ---------------------------------------------------------
                  // LÂMINAS RECENTES
                  // ---------------------------------------------------------
                  Text(
                    "Lâminas recentes",
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16),

                  _slidesPreviewSection(isWide),

                  const SizedBox(height: 40),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  /// AppBar da página inicial.
  AppBar _homeAppBar(BuildContext context) {
    final theme = Theme.of(context);
    return AppBar(
      // aparência
      backgroundColor: theme.colorScheme.primary,
      foregroundColor: theme.colorScheme.onPrimary,
      // título da página
      title: Text(
        "Atlas Digital",
        style: theme.textTheme.headlineMedium?.copyWith(
          color: theme.colorScheme.onPrimary,
        ),
      ),
      centerTitle: true,
    );
  }
}

  // ===========================================================================
  // WIDGET — Botões principais
  // ===========================================================================
  Widget _homeButton(BuildContext context, String label, IconData icon, String route) {
    final theme = Theme.of(context);
    
    return SizedBox(
      height: 80,
      child: ElevatedButton(
        onPressed: () => /*context.go(route)*/{},
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 235, 235, 235),
          foregroundColor: const Color.fromARGB(255, 90, 150, 92),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 33),
            const SizedBox(width: 16),
            Text(
              label,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===========================================================================
  // WIDGET — Pré-visualização das lâminas (placeholder)
  // ===========================================================================
  Widget _slidesPreviewSection(bool isWide) {
    return SizedBox(
      height: 160,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: List.generate(
          6,
          (i) => Container(
            width: isWide ? 220 : 140,
            margin: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(child: Text("Prévia")),
          ),
        ),
      ),
    );
  }
