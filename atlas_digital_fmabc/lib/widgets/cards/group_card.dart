import 'package:atlas_digital_fmabc/models/groups/group_model.dart';
import 'package:flutter/material.dart';

/// Card de tema.
class GroupCard extends StatelessWidget {
  const GroupCard({super.key, required this.group});

  final GroupModel group;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Nome do tema
            Text(group.name, style: theme.textTheme.titleMedium),
            // Quantidade de lâminas
            Text(
              "${group.quantSlides} lâminas",
              style: theme.textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
