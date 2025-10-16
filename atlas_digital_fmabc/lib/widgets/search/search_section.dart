import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

/// Seção com a caixa de pesquisa.
class SearchSection extends StatelessWidget {
  const SearchSection({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/bg/search-bg.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 44.0),
        child: Center(child: searchBar(context)),
      ),
    );
  }

  /// Caixa de pesquisa.
  SearchBar searchBar(BuildContext context) {
    return SearchBar(
      hintText: "Pesquisar lâminas",
      trailing: [
        IconButton(onPressed: () {}, icon: Icon(FluentIcons.search_24_filled)),
      ],
    );
  }
}
