import 'package:atlas_digital_fmabc/data/notifiers.dart';
import 'package:atlas_digital_fmabc/views/pages/categories_page.dart';
import 'package:atlas_digital_fmabc/views/pages/groups_page.dart';
import 'package:atlas_digital_fmabc/views/pages/most_recents_page.dart';
import 'package:flutter/material.dart';
import 'package:atlas_digital_fmabc/views/widgets/navigation/navbar_widget.dart';

List<Widget> pages = [CategoriesPage(), GroupsPage(), MostRecentsPage()];

class WidgetTree extends StatelessWidget {
  const WidgetTree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // layout
      appBar: _mainAppBar(context),
      bottomNavigationBar: NavbarWidget(),
      // conteúdo
      body: ValueListenableBuilder(
        valueListenable: selectedPageNotifier,
        builder: (context, selectedPage, child) {
          return pages.elementAt(selectedPage);
        },
      ),
    );
  }

  AppBar _mainAppBar(BuildContext context) {
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
