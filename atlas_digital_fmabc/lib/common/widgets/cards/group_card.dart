import 'package:atlas_digital_fmabc/models/groups/group_model.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';


/// Card de tema.
class GroupCard extends StatelessWidget {
  const GroupCard({super.key, required this.group, required this.onTap});

  final GroupModel group;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () {
          onTap();
        },
        child: 
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 4.0,
            children: [
              // Nome do tema
              Text(
                group.name,
                style: theme.textTheme.titleMedium,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              // Quantidade de lâminas
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                spacing: 2.0,
                children: [
                  Icon(
                    FluentIcons.microscope_20_filled,
                    color: theme.colorScheme.outline,
                  ),
                  Text(
                    group.quantSlides.toString(),
                    style: theme.textTheme.bodyMedium,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
