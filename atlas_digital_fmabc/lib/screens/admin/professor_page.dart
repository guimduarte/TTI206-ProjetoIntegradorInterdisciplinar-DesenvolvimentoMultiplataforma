import 'package:atlas_digital_fmabc/common/widgets/upload/upload_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:atlas_digital_fmabc/config/routes/routes.dart';

class ProfessorArea extends StatefulWidget {
  const ProfessorArea({super.key});

  @override
  State<ProfessorArea> createState() => _ProfessorAreaState();
}

class _ProfessorAreaState extends State<ProfessorArea> {
  final TextEditingController _temaController = TextEditingController();
  final List<String> temas = [];


  Widget _buildSectionCard({
    required String title,
    required List<Widget> children,
  }) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 16),
            ...children,
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        title: const Text("Área do Professor"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: "Voltar para o Início",
          onPressed: () {
            context.go(Routes.homePage);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Upload de Imagens
              _buildSectionCard(
                title: "Upload de Imagens",
                children: [
                  const UploadImage(),
                ],
              ),

              //Criação de Temas
              _buildSectionCard(
                title: "Criação de Temas",
                children: [
                  TextField(
                    controller: _temaController,
                    decoration: const InputDecoration(
                      labelText: "Nome do Tema",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      hintText: "Ex: Histologia Básica",
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      if (_temaController.text.isNotEmpty &&
                          !temas.contains(_temaController.text)) {
                        setState(() {
                          temas.add(_temaController.text);
                          _temaController.clear();
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      foregroundColor:
                          Theme.of(context).colorScheme.onSecondary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      minimumSize: const Size(double.infinity, 48),
                    ),
                    child: const Text("Criar Tema"),
                  ),
                ],
              ),

              //Lista de Temas Criados
              _buildSectionCard(
                title: "Temas Criados (${temas.length})",
                children: temas.isEmpty
                    ? [
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("Nenhum tema criado ainda."),
                          ),
                        ),
                      ]
                    : temas.asMap().entries.map((entry) {
                        int index = entry.key;
                        String tema = entry.value;
                        return Column(
                          children: [
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Text(tema),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.edit,
                                        color: Colors.blue),
                                    onPressed: () async {
                                      String? novoTema = await showDialog(
                                        context: context,
                                        builder: (context) {
                                          final controller =
                                              TextEditingController(text: tema);
                                          return AlertDialog(
                                            title: const Text("Editar Tema"),
                                            content: TextField(
                                                controller: controller),
                                            actions: [
                                              TextButton(
                                                onPressed: () =>
                                                    Navigator.pop(context),
                                                child: const Text("Cancelar"),
                                              ),
                                              ElevatedButton(
                                                onPressed: () => Navigator.pop(
                                                    context, controller.text),
                                                child: const Text("Salvar"),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                      if (novoTema != null &&
                                          novoTema.isNotEmpty) {
                                        setState(() {
                                          temas[index] = novoTema;
                                        });
                                      }
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete,
                                        color: Colors.red),
                                    onPressed: () {
                                      setState(() {
                                        temas.removeAt(index);
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}