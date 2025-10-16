import 'package:atlas_digital_fmabc/models/groups/group_model.dart';
import 'package:atlas_digital_fmabc/widgets/cards/group_card.dart';
import 'package:flutter/material.dart';

/// Seção de lista de temas.
class GroupList extends StatelessWidget {
  const GroupList({super.key, required this.list});

  final List<GroupModel> list;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ListView.separated(
        itemCount: 10,
        // espaçamento
        separatorBuilder: (context, index) => const SizedBox(height: 14),
        // cards
        itemBuilder: (context, index) => GroupCard(group: list[index]),
      ),
    );
  }
}
