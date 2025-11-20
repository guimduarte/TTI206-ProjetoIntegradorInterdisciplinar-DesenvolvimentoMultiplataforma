import 'package:atlas_digital_fmabc/common/widgets/cards/image_visualizer.dart';
import 'package:atlas_digital_fmabc/models/image_model.dart';
import 'package:flutter/material.dart';

class ExibicaoImagensPage extends StatefulWidget {

  final ImageModel imagem;

  const ExibicaoImagensPage({super.key, required this.imagem});

  @override
  State<ExibicaoImagensPage> createState() => _ExibicaoImagensPageState();
}

class _ExibicaoImagensPageState extends State<ExibicaoImagensPage> {

  bool espelhado = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // layout
      appBar: _savedAppBar(context),
      // conteúdo
      body:
LayoutBuilder(
  builder: (context, constraints) {
    final double screenHeight = MediaQuery.of(context).size.height;

    if (constraints.maxWidth < 600) {
      // 📱 Telas pequenas: empilha (imagem + texto) e tudo rola junto
      return SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              height: screenHeight * 0.5, // metade da tela visível
              child: 
                Stack(
                  children:[ 
                    Center(
                      child: Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.identity()..scale(espelhado ? -1.0 : 1.0, 1.0, 1.0),
                        child: ImageVisualizer(
                          imageName: widget.imagem.nome,
                          espelhado: espelhado,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 10,
                      bottom: 10,
                      child: FloatingActionButton(
                        tooltip: 'Espelhar mapa',
                        child: const Icon(Icons.flip),
                        onPressed: () {
                          setState(() {
                            espelhado = !espelhado;
                          });
                        },
                      ),
                    ),
                  ]
                ),
            ),
            const SizedBox(height: 8),
            Text(widget.imagem.descricao,
              softWrap: true,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      );
    } else {
      // 🖥️ Telas grandes: imagem ocupa toda a altura, texto rola independente
      return Row(
        crossAxisAlignment: CrossAxisAlignment.stretch, // estica a imagem verticalmente
        children: [
          // imagem usa toda a altura da tela
          SizedBox(
            width: constraints.maxWidth * 0.7,
            height: screenHeight, // ocupa toda a altura visível
            child: Stack(
              children: [
                Center(
                  child: Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()..scale(espelhado ? -1.0 : 1.0, 1.0, 1.0),
                    child: ImageVisualizer(
                      imageName: widget.imagem.nome,
                      espelhado: espelhado,
                    ),
                  ),
                ),
                Positioned(
                  right: 10,
                  bottom: 10,
                  child: FloatingActionButton(
                    tooltip: 'Espelhar mapa',
                    child: const Icon(Icons.flip),
                    onPressed: () {
                      setState(() {
                        espelhado = !espelhado;
                      });
                    },
                  ),
                ),
              ]
            ),
          ),
          const SizedBox(width: 12),

          // texto rola à direita
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Scrollbar(
                thumbVisibility: true,
                child: SingleChildScrollView(
                  child: Text(widget.imagem.descricao,
                    softWrap: true,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    }
  },
)

    );
  }

  AppBar _savedAppBar(BuildContext context) {
    final theme = Theme.of(context);
    return AppBar(
      // aparência
      backgroundColor: theme.colorScheme.primary,
      foregroundColor: theme.colorScheme.onPrimary,
      // título da página
      title: Text(
        "Imagem Teste",
        style: theme.textTheme.headlineMedium?.copyWith(
          color: theme.colorScheme.onPrimary,
        ),
      ),
      centerTitle: true,
    );
  }
}
