import 'dart:async';

import 'package:atlas_digital_fmabc/common/widgets/cards/image_visualizer.dart';
import 'package:atlas_digital_fmabc/models/image_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExibicaoImagensPage extends StatefulWidget {
  final ImageModel imagem;

  const ExibicaoImagensPage({super.key, required this.imagem});

  @override
  State<ExibicaoImagensPage> createState() => _ExibicaoImagensPageState();
}

class _ExibicaoImagensPageState extends State<ExibicaoImagensPage> {
  bool espelhado = false;
  bool saved = false;

  Future<bool> getSaved(String imageName) async {
    final SharedPreferencesAsync asyncPrefs = SharedPreferencesAsync();
    var savedImageNames = await asyncPrefs.getStringList("savedItens");
    if (savedImageNames == null) {
      setState(() {
        saved = false;
      });
      return false;
    }
    setState(() {
      saved = savedImageNames.contains(imageName);
    });
    return saved;
  }

  Future<void> setSaved(String imageName) async {
    final SharedPreferencesAsync asyncPrefs = SharedPreferencesAsync();
    var savedImageNames = await asyncPrefs.getStringList("savedItens");
    if (savedImageNames == null) {
      await asyncPrefs.setStringList("savedItens", [imageName]);
      setState(() {
        saved = true;
      });
    } else if (savedImageNames.contains(imageName)) {
      savedImageNames.remove(imageName);
      await asyncPrefs.setStringList("savedItens", savedImageNames);
      setState(() {
        saved = false;
      });
    } else {
      savedImageNames.add(imageName);
      await asyncPrefs.setStringList("savedItens", savedImageNames);
      setState(() {
        saved = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // layout
      appBar: _savedAppBar(context),
      // conteúdo
      body: LayoutBuilder(
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
                    child: Stack(
                      children: [
                        Center(
                          child: Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.identity()
                              ..scale(espelhado ? -1.0 : 1.0, 1.0, 1.0),
                            child: ImageVisualizer(
                              imageName: widget.imagem.nome,
                              espelhado: espelhado,
                            ),
                          ),
                        ),
                        Positioned(
                          right: 10,
                          bottom: 30,
                          child: Column(
                            spacing: 10,
                            children: [
                              FutureBuilder(
                                future: getSaved(widget.imagem.nome),
                                builder: (context, asyncSnapshot) {
                                  if (asyncSnapshot.hasData) {
                                    return FloatingActionButton(
                                      tooltip: "Salvar imagem",
                                      child: saved
                                          ? const Icon(Icons.favorite_outlined)
                                          : const Icon(Icons.favorite_outline),
                                      onPressed: () {
                                        setSaved(widget.imagem.nome).then((e) {
                                          print("enviado");
                                        });
                                      },
                                    );
                                  } else if (asyncSnapshot.hasError) {
                                    return FloatingActionButton(
                                      tooltip:
                                          "Houve um erro ao obter os itens salvos",
                                      child: const Icon(Icons.error),
                                      onPressed: () {},
                                    );
                                  } else {
                                    return FloatingActionButton(
                                      child: CircularProgressIndicator(),
                                      onPressed: () {},
                                    );
                                  }
                                },
                              ),
                              FloatingActionButton(
                                tooltip: 'Espelhar mapa',
                                child: const Icon(Icons.flip),
                                onPressed: () {
                                  setState(() {
                                    espelhado = !espelhado;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.imagem.descricao,
                    softWrap: true,
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            );
          } else {
            // 🖥️ Telas grandes: imagem ocupa toda a altura, texto rola independente
            return Row(
              crossAxisAlignment:
                  CrossAxisAlignment.stretch, // estica a imagem verticalmente
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
                          transform: Matrix4.identity()
                            ..scale(espelhado ? -1.0 : 1.0, 1.0, 1.0),
                          child: ImageVisualizer(
                            imageName: widget.imagem.nome,
                            espelhado: espelhado,
                          ),
                        ),
                      ),
                      Positioned(
                        right: 10,
                        bottom: 30,
                        child: Column(
                          spacing: 10,
                          children: [
                            FutureBuilder(
                              future: getSaved(widget.imagem.nome),
                              builder: (context, asyncSnapshot) {
                                if (asyncSnapshot.hasData) {
                                  return FloatingActionButton(
                                    tooltip: "Salvar imagem",
                                    child: saved
                                        ? const Icon(Icons.favorite_outlined)
                                        : const Icon(Icons.favorite_outline),
                                    onPressed: () {
                                      setSaved(widget.imagem.nome).then((e) {
                                        print("enviado");
                                      });
                                    },
                                  );
                                } else if (asyncSnapshot.hasError) {
                                  return FloatingActionButton(
                                    tooltip:
                                        "Houve um erro ao obter os itens salvos",
                                    child: const Icon(Icons.error),
                                    onPressed: () {},
                                  );
                                } else {
                                  return FloatingActionButton(
                                    child: CircularProgressIndicator(),
                                    onPressed: () {},
                                  );
                                }
                              },
                            ),
                            FloatingActionButton(
                              tooltip: 'Espelhar mapa',
                              child: const Icon(Icons.flip),
                              onPressed: () {
                                setState(() {
                                  espelhado = !espelhado;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
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
                        child: Text(
                          widget.imagem.descricao,
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
      ),
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
