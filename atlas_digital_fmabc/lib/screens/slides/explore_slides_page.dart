import 'package:atlas_digital_fmabc/data/mock/mock_themes.dart';
import 'package:atlas_digital_fmabc/common/widgets/layout/app_bar/title_and_supporting_text.dart';
import 'package:atlas_digital_fmabc/widgets/lists/group_list.dart';
import 'package:atlas_digital_fmabc/widgets/search/search_section.dart';
import 'package:flutter/material.dart';

/// Página inicial da aba lâminas.
/// Exibe uma caixa de pesquisa e os temas de lâminas.
class ExploreSlidesPage extends StatelessWidget {
  ExploreSlidesPage({super.key}); // Construtor padrão

  // TODO: obter temas e turmas do BD

  final themesList = mockThemes;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // número de abas
      child: Scaffold(
        // layout
        appBar: _slidesAppBar(context),
        // conteúdo
        body: Column(
          children: [
            SearchSection(), // barra de Pesquisa

            TabBar(
              tabs: [
                Tab(text: "Temas"),
                Tab(text: "Turmas"),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  GroupList(list: mockThemes),
                  Text("Turmas"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// AppBar da página de lâminas.
  AppBar _slidesAppBar(BuildContext context) {
    final theme = Theme.of(context);
    return AppBar(
      // aparência
      backgroundColor: theme.colorScheme.primary,
      foregroundColor: theme.colorScheme.onPrimary,
      // título da página
      title: TitleAndSupportingText(
        title: "Explorar Lâminas",
        supportingText: "FMABC | Atlas Digital de Biologia Tecidual",
        color: theme.colorScheme.onPrimary,
      ),
      centerTitle: true,
    );
  }
}
