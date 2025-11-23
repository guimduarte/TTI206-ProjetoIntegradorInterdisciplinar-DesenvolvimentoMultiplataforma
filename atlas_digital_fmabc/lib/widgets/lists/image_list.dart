import 'package:atlas_digital_fmabc/common/widgets/cards/image_card.dart';
import 'package:atlas_digital_fmabc/models/image_model.dart';
import 'package:flutter/material.dart';

class ImageList extends StatelessWidget {
  const ImageList({super.key, required this.listaDeImagens});

  final List<ImageModel> listaDeImagens;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
      itemCount: listaDeImagens.length,
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 360, // width máxima do card
        mainAxisExtent: 300, // height do card
        // espaçamento
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
      ),

      // cards
      itemBuilder: (context, index) => ImageCard(imagemDesseCard: listaDeImagens[index]),
    );
  }
}