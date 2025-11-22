import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:atlas_digital_fmabc/widgets/form/cadastro_form.dart';
import 'package:atlas_digital_fmabc/services/auth_service.dart';
import 'package:atlas_digital_fmabc/services/category_service.dart';
import 'package:atlas_digital_fmabc/widgets/form/image_editor_form.dart';
import 'package:go_router/go_router.dart';
import 'package:atlas_digital_fmabc/config/routes/routes.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final AuthService _authService = AuthService();
  final CategoryService _categoryService = CategoryService();

  final TextEditingController _temaController = TextEditingController();
  List<Map<String, dynamic>> categorias = [];
  List<String> imagensDisponiveis = [];
  final List<String> imagens = [];

  List<Map<String, dynamic>> usuarios = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchProfessores();
    _fetchCategorias();
    _fetchImagensDisponiveis();
  }

  Future<void> _fetchImagensDisponiveis() async {
    final resultado = await _categoryService.fetchAvailableImages();
    if (resultado.containsKey("success")) {
      setState(() {
        imagensDisponiveis = List<String>.from(resultado["data"]);
      });
    } else {
      print(
        "Aviso: Não foi possível carregar a lista de imagens para tagging.",
      );
    }
  }

  Future<void> _fetchCategorias() async {
    final resultado = await _categoryService.fetchCategories();
    if (resultado.containsKey("success")) {
      setState(() {
        categorias = (resultado["data"] as List)
            .map((item) => item as Map<String, dynamic>)
            .toList();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(resultado["message"]),
          backgroundColor: Colors.red.shade600,
        ),
      );
    }
  }

  Future<void> _handleCreateCategory() async {
    final newName = _temaController.text.trim();
    if (newName.isEmpty) return;

    final resultado = await _categoryService.createCategory(
      categoryName: newName,
    );

    if (resultado.containsKey("success")) {
      _temaController.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(resultado["message"]),
          backgroundColor: Colors.green.shade700,
        ),
      );
      await _fetchCategorias();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(resultado["message"]),
          backgroundColor: Colors.red.shade700,
        ),
      );
    }
  }

  Future<void> _handleDeleteCategory(String categoryName) async {
    final resultado = await _categoryService.deleteCategory(
      categoryName: categoryName,
    );

    if (resultado.containsKey("success")) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(resultado["message"]),
          backgroundColor: Colors.green.shade700,
        ),
      );
      await _fetchCategorias();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(resultado["message"]),
          backgroundColor: Colors.red.shade700,
        ),
      );
    }
  }

  Future<void> _fetchProfessores() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final url = Uri.parse('http://localhost:8000/users');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);

        usuarios = jsonList.map((item) {
          final is_admin = item['tipo'] == 'admin';
          return {
            'nome': item['nome']?.toString() ?? 'Nome Indisponível',
            'email': item['email']?.toString() ?? 'Email Indisponível',
            'is_admin': is_admin,
          };
        }).toList();
      } else {
        usuarios = [
          {
            'nome': 'Status ${response.statusCode}',
            'email': 'Verifique o endpoint /users',
            'is_admin': true,
          },
        ];
      }
    } catch (e) {
      usuarios = [
        {
          'nome': 'Erro de Rede',
          'email': 'Não foi possível conectar',
          'is_admin': true,
        },
      ];
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Método auxiliar para criar cards de seção
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

  // Método para isolar a lógica do diálogo de edição de categorias
  void _showEditDialog(String oldName, String currentName) async {
    final categoriaExistente = categorias.firstWhere(
      (cat) => cat["category_name"] == oldName,
      orElse: () => {"images": []} as Map<String, dynamic>,
    );
    Set<String> imagensSelecionadas = Set.from(
      categoriaExistente["images"]?.cast<String>() ?? [],
    );
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (context) {
        final controller = TextEditingController(text: currentName);
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setStateDialog) {
            return AlertDialog(
              title: const Text("Editar Categoria"),
              content: SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Nome da Categoria:",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextField(controller: controller),
                      const SizedBox(height: 15),
                      const Text(
                        "Imagens Associadas:",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      ...imagensDisponiveis.map((imgName) {
                        return CheckboxListTile(
                          dense: true,
                          title: Text(
                            imgName,
                            style: const TextStyle(fontSize: 14),
                          ),
                          value: imagensSelecionadas.contains(imgName),
                          onChanged: (bool? newValue) {
                            setStateDialog(() {
                              if (newValue == true) {
                                imagensSelecionadas.add(imgName);
                              } else {
                                imagensSelecionadas.remove(imgName);
                              }
                            });
                          },
                        );
                      }).toList(),
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancelar"),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context, {
                    'new_name': controller.text.trim(),
                    'new_images': imagensSelecionadas.toList(),
                  }),
                  child: const Text("Salvar"),
                ),
              ],
            );
          },
        );
      },
    );

    if (result != null && result is Map) {
      final newName = result['new_name'];
      final newImages = result['new_images'];

      if (newName.isNotEmpty &&
          (newName != currentName ||
              newImages != (categoriaExistente["images"] ?? []))) {
        final resultado = await _categoryService.updateCategory(
          oldName: oldName,
          newName: newName,
          newImages: newImages.cast<String>(),
        );

        if (resultado.containsKey("success")) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(resultado["message"]),
              backgroundColor: Colors.green.shade700,
            ),
          );
          await _fetchCategorias(); // Recarrega para mostrar o novo nome e as tags
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(resultado["message"]),
              backgroundColor: Colors.red.shade700,
            ),
          );
        }
      }
    }
  }

  @override
  void dispose() {
    _temaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final totalUsers = usuarios.length;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        title: const Text("Área do Admin"),
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
              //CADASTRO
              _buildSectionCard(
                title: "Cadastro de Novos Usuários",
                children: [CadastroForm(onCadastroSuccess: _fetchProfessores)],
              ),

              //Lista de usuarios
              _buildSectionCard(
                title: "Professores Cadastrados ($totalUsers)",
                children: [
                  _isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : usuarios.isEmpty
                      ? const Center(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "Nenhum professor encontrado. Tente recarregar ou verifique a API.",
                            ),
                          ),
                        )
                      : Column(
                          children: usuarios.map((user) {
                            final isAdmin = user['is_admin'] as bool;
                            final userEmail = user['email']!;

                            return ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: Icon(
                                isAdmin ? Icons.security : Icons.school,
                                color: isAdmin
                                    ? Colors.deepOrange
                                    : Colors.blueGrey,
                              ),
                              title: Text(user['nome']!),
                              subtitle: Text(userEmail),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // Chip
                                  Chip(
                                    label: Text(
                                      isAdmin ? "Admin" : "Professor",
                                    ),
                                    backgroundColor: isAdmin
                                        ? Colors.deepOrange.shade100
                                        : Colors.blue.shade100,
                                    labelStyle: TextStyle(
                                      color: isAdmin
                                          ? Colors.deepOrange.shade900
                                          : Colors.blue.shade900,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10,
                                    ),
                                  ),
                                  const SizedBox(width: 8),

                                  //LIXEIRA
                                  IconButton(
                                    icon: Icon(
                                      Icons.delete,
                                      color: isAdmin ? Colors.grey : Colors.red,
                                    ),
                                    onPressed: isAdmin
                                        ? null
                                        : () async {
                                            setState(() {
                                              _isLoading = true;
                                            });
                                            final resultado = await _authService
                                                .deleteUser(email: userEmail);

                                            if (resultado.containsKey(
                                              'success',
                                            )) {
                                              // SnackBar de sucesso
                                              ScaffoldMessenger.of(
                                                context,
                                              ).showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    resultado['message'],
                                                  ),
                                                  backgroundColor:
                                                      Colors.green.shade700,
                                                ),
                                              );
                                              await _fetchProfessores();
                                            } else {
                                              // SnackBar de erro
                                              ScaffoldMessenger.of(
                                                context,
                                              ).showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    resultado['message'] ??
                                                        'Erro desconhecido na deleção.',
                                                  ),
                                                  backgroundColor:
                                                      Colors.red.shade700,
                                                ),
                                              );
                                              setState(() {
                                                _isLoading = false;
                                              });
                                            }
                                          },
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                  if (!_isLoading)
                    TextButton.icon(
                      onPressed: _fetchProfessores,
                      icon: const Icon(Icons.refresh),
                      label: const Text("Recarregar Lista"),
                    ),
                ],
              ),

              _buildSectionCard(
                title: "Upload de Imagens",
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        imagens.add("Imagem ${imagens.length + 1}");
                      });
                    },
                    icon: const Icon(Icons.cloud_upload),
                    label: const Text("Adicionar Imagem"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Theme.of(context).colorScheme.onPrimary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: imagens
                        .map((img) => Chip(label: Text(img)))
                        .toList(),
                  ),
                ],
              ),

              const SizedBox(height: 24),
              _buildSectionCard(
                title: "Gerenciar Imagens do Banco",
                children: [
                  if (imagensDisponiveis.isEmpty)
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Nenhuma imagem encontrada"),
                    ),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: imagensDisponiveis.map((imgName) {
                      return ActionChip(
                        elevation: 1,
                        avatar: const Icon(
                          Icons.edit,
                          size: 16,
                          color: Colors.blueGrey,
                        ),
                        label: Text(imgName),
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.all(8),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: ConstrainedBox(
                                  constraints: const BoxConstraints(
                                    maxWidth: 450,
                                  ),
                                  child: ImageEditorForm(
                                    imageName: imgName,
                                    currentDescription: "",
                                    onSuccess: () {
                                      _fetchImagensDisponiveis();
                                      _fetchCategorias();
                                    },
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      );
                    }).toList(),
                  ),
                ],
              ),

              // Criação de Categorias
              _buildSectionCard(
                title: "Criação de Temas",
                children: [
                  TextField(
                    controller: _temaController,
                    decoration: const InputDecoration(
                      labelText: "Nome da Categoria",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      hintText: "Ex: Célula 1, Célula 2, Guigo",
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _handleCreateCategory,
                    child: const Text("Criar Categoria"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      foregroundColor: Theme.of(
                        context,
                      ).colorScheme.onSecondary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      minimumSize: const Size(double.infinity, 48),
                    ),
                  ),
                ],
              ),

              // Lista de Categorias
              _buildSectionCard(
                title: "Categorias Criadas (${categorias.length})",
                children: categorias.isEmpty
                    ? [
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("Nenhum tema criado ainda."),
                          ),
                        ),
                      ]
                    : categorias.asMap().entries.map((entry) {
                        int index = entry.key;
                        final category = entry.value;
                        final categoryName =
                            category["category_name"] as String;
                        return Column(
                          children: [
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Text(categoryName),
                              subtitle: Text(
                                'Imagens Associadas: ${category["images"]?.length ?? 0}',
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(
                                      Icons.edit,
                                      color: Colors.blue,
                                    ),
                                    onPressed: () => _showEditDialog(
                                      categoryName,
                                      categoryName,
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                    onPressed: () =>
                                        _handleDeleteCategory(categoryName),
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
