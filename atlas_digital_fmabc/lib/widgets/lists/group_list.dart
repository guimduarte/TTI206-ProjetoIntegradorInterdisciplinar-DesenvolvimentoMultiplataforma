import 'package:atlas_digital_fmabc/models/groups/group_model.dart';
import 'package:atlas_digital_fmabc/widgets/cards/group_card.dart';
import 'package:flutter/material.dart';

/// Seção de lista de temas.
class GroupList extends StatelessWidget {
  const GroupList({super.key, required this.list});

  final List<GroupModel> list;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
      itemCount: 10,
      // espaçamento
      separatorBuilder: (context, index) => const SizedBox(height: 8.0),
      // cards
      itemBuilder: (context, index) => GroupCard(group: list[index]),
    );
  }
}
