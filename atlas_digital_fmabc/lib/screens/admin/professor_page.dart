import 'package:flutter/material.dart';

class ProfessorArea extends StatefulWidget {
  const ProfessorArea({super.key});

  @override
  State<ProfessorArea> createState() => _ProfessorAreaState();
}

class _ProfessorAreaState extends State<ProfessorArea> {
  final TextEditingController _temaController = TextEditingController();
  final List<String> temas = [];
  final List<String> imagens = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        title: const Text("Área do Professor"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Botão de Upload de Imagens
              const Text(
                "Upload de Imagens",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  // Exemplo de upload de imagem
                  setState(() {
                    imagens.add("Imagem ${imagens.length + 1}");
                  });
                },
                child: const Text("Adicionar Imagem"),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children:
                    imagens.map((img) => Chip(label: Text(img))).toList(),
              ),

              const Divider(height: 32),

              // Criação de Temas
              const Text(
                "Criação de Temas",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _temaController,
                decoration: const InputDecoration(
                  labelText: "Nome do Tema",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 8),
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
                child: const Text("Criar Tema"),
              ),

              const Divider(height: 32),

              // Edição de Temas
              const Text(
                "Temas Criados",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              ...temas.asMap().entries.map((entry) {
                int index = entry.key;
                String tema = entry.value;
                return ListTile(
                  title: Text(tema),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () async {
                          String? novoTema = await showDialog(
                            context: context,
                            builder: (context) {
                              final controller =
                                  TextEditingController(text: tema);
                              return AlertDialog(
                                title: const Text("Editar Tema"),
                                content: TextField(controller: controller),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
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
                          if (novoTema != null && novoTema.isNotEmpty) {
                            setState(() {
                              temas[index] = novoTema;
                            });
                          }
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          setState(() {
                            temas.removeAt(index);
                          });
                        },
                      ),
                    ],
                  ),
                );
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }
}