import 'package:atlas_digital_fmabc/models/groups/group_model.dart';
import 'package:atlas_digital_fmabc/widgets/cards/group_card.dart';
import 'package:flutter/material.dart';

/// Seção de lista de temas.
class GroupList extends StatelessWidget {
  const GroupList({super.key, required this.list});

  final List<GroupModel> list;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
      itemCount: list.length,
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 360, // width máxima do card
        mainAxisExtent: 94, // height do card
        // espaçamento
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
      ),

      // cards
      itemBuilder: (context, index) => GroupCard(group: list[index]),
    );
  }
}
