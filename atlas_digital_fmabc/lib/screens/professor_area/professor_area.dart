import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfessorArea extends StatefulWidget {
  const ProfessorArea({super.key});

  @override
  State<ProfessorArea> createState() => _ProfessorAreaState();
}

class _ProfessorAreaState extends State<ProfessorArea> {
  final TextEditingController _temaController = TextEditingController();
  final List<String> temas = [];
  final List<File> imagens = [];

  final ImagePicker _picker = ImagePicker();

  // 📸 Função para pegar imagem da galeria ou câmera
  Future<void> _adicionarImagem() async {
    final XFile? imagemSelecionada = await _picker.pickImage(
      source: ImageSource.gallery, // Pode trocar pra .camera se quiser
      imageQuality: 80, // reduz o tamanho da imagem sem perder muita qualidade
    );

    if (imagemSelecionada != null) {
      setState(() {
        imagens.add(File(imagemSelecionada.path));
      });
    }
  }

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
              // Upload de Imagens
              const Text(
                "Upload de Imagens",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: _adicionarImagem,
                child: const Text("Adicionar Imagem"),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: imagens.map((img) {
                  return Stack(
                    alignment: Alignment.topRight,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(
                          img,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              imagens.remove(img);
                            });
                          },
                          child: Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.black54,
                            ),
                            padding: const EdgeInsets.all(4),
                            child: const Icon(Icons.close, color: Colors.white, size: 16),
                          ),
                        ),
                      ),
                    ],
                  );
                }).toList(),
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
                              final controller = TextEditingController(text: tema);
                              return AlertDialog(
                                title: const Text("Editar Tema"),
                                content: TextField(controller: controller),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text("Cancelar"),
                                  ),
                                  ElevatedButton(
                                    onPressed: () =>
                                        Navigator.pop(context, controller.text),
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
