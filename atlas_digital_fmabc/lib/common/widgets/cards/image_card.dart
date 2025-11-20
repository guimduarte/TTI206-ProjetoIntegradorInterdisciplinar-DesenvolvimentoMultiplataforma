import 'dart:convert';

import 'package:atlas_digital_fmabc/models/image_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ImageCard extends StatelessWidget {
  const ImageCard({super.key, required this.imagemDesseCard});

  final ImageModel imagemDesseCard;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () {
          context.go('/laminas/imagem/${imagemDesseCard.id}', extra: imagemDesseCard);
        },
        child: 
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 4.0,
            children: [
              // Nome da imagem
              Text(
                imagemDesseCard.nome,
                style: theme.textTheme.titleMedium,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              // Quantidade de lâminas
              Image.memory(base64Decode(imagemDesseCard.url), fit: BoxFit.fill,)
            ],
          ),
        ),
      ),
    );
  }
}
