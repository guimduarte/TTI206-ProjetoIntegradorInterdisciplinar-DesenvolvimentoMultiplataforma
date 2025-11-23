import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:go_router/go_router.dart';
import 'package:atlas_digital_fmabc/config/routes/routes.dart';
import 'package:atlas_digital_fmabc/common/widgets/upload/upload_image.dart'; // Importe o UploadImage
import 'package:atlas_digital_fmabc/widgets/form/cadastro_form.dart';
import 'package:atlas_digital_fmabc/widgets/form/image_editor_form.dart';
import 'package:atlas_digital_fmabc/services/auth_service.dart';
import 'package:atlas_digital_fmabc/services/category_service.dart';

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
      _showSnack(resultado["message"], isError: false);
      await _fetchCategorias();
    } else {
      _showSnack(resultado["message"], isError: true);
    }
  }

  Future<void> _handleDeleteCategory(String categoryName) async {
    final resultado = await _categoryService.deleteCategory(
      categoryName: categoryName,
    );

    if (resultado.containsKey("success")) {
      _showSnack(resultado["message"], isError: false);
      await _fetchCategorias();
    } else {
      _showSnack(resultado["message"], isError: true);
    }
  }

  Future<void> _fetchProfessores() async {
    setState(() => _isLoading = true);
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
      }
    } catch (e) {
      // trata erro ou exibe warning
    } finally {
      setState(() => _isLoading = false);
    }
  }


  void _showSnack(String msg, {required bool isError}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: isError ? Colors.red.shade700 : Colors.green.shade700,
      ),
    );
  }

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
                      const Text("Nome:", style: TextStyle(fontWeight: FontWeight.bold)),
                      TextField(controller: controller),
                      const SizedBox(height: 15),
                      const Text("Imagens:", style: TextStyle(fontWeight: FontWeight.bold)),
                      ...imagensDisponiveis.map((imgName) {
                        return CheckboxListTile(
                          dense: true,
                          title: Text(imgName, style: const TextStyle(fontSize: 14)),
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
                TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancelar")),
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

    if (result != null) {
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
          _showSnack(resultado["message"], isError: false);
          await _fetchCategorias();
        } else {
          _showSnack(resultado["message"], isError: true);
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
          onPressed: () => context.go(Routes.homePage),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Usuarios
              _buildSectionCard(
                title: "Cadastro de Novos Usuários",
                children: [CadastroForm(onCadastroSuccess: _fetchProfessores)],
              ),

              _buildSectionCard(
                title: "Professores Cadastrados ($totalUsers)",
                children: [
                  if (_isLoading)
                    const Center(child: CircularProgressIndicator())
                  else if (usuarios.isEmpty)
                    const Text("Nenhum professor encontrado.")
                  else
                    Column(
                      children: usuarios.map((user) {
                        final isAdmin = user['is_admin'] as bool;
                        final userEmail = user['email']!;
                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: Icon(
                            isAdmin ? Icons.security : Icons.school,
                            color: isAdmin ? Colors.deepOrange : Colors.blueGrey,
                          ),
                          title: Text(user['nome']!),
                          subtitle: Text(userEmail),
                          trailing: IconButton(
                            icon: Icon(Icons.delete,
                                color: isAdmin ? Colors.grey : Colors.red),
                            onPressed: isAdmin
                                ? null
                                : () async {
                                    setState(() => _isLoading = true);
                                    final res = await _authService.deleteUser(
                                        email: userEmail);
                                    _showSnack(res['message'] ?? 'Erro',
                                        isError: res.containsKey('error'));
                                    await _fetchProfessores();
                                  },
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

              // Upload Imagens
              _buildSectionCard(
                title: "Upload de Imagens",
                children: [
                  const UploadImage(),
                ],
              ),

              const SizedBox(height: 24),

              //imagens banco gerenciar
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
                        avatar: const Icon(Icons.edit, size: 16, color: Colors.blueGrey),
                        label: Text(imgName),
                        backgroundColor: Colors.white,
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => Dialog(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              child: ConstrainedBox(
                                constraints: const BoxConstraints(maxWidth: 450),
                                child: ImageEditorForm(
                                  imageName: imgName,
                                  currentDescription: "", 
                                  onSuccess: () {
                                    _fetchImagensDisponiveis();
                                    _fetchCategorias();
                                  },
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                ],
              ),

              //temas/ categorias como quisr chamar
              _buildSectionCard(
                title: "Criação de Temas",
                children: [
                  TextField(
                    controller: _temaController,
                    decoration: const InputDecoration(
                      labelText: "Nome da Categoria",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      hintText: "Ex: Célula 1, Guigo",
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _handleCreateCategory,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      foregroundColor: Theme.of(context).colorScheme.onSecondary,
                      minimumSize: const Size(double.infinity, 48),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Text("Criar Categoria"),
                  ),
                ],
              ),

              // lista temas/categorias
              _buildSectionCard(
                title: "Categorias Criadas (${categorias.length})",
                children: categorias.isEmpty
                    ? [const Center(child: Text("Nenhum tema criado ainda."))]
                    : categorias.map((category) {
                        final categoryName = category["category_name"] as String;
                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(categoryName),
                          subtitle: Text('Imagens: ${category["images"]?.length ?? 0}'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit, color: Colors.blue),
                                onPressed: () => _showEditDialog(categoryName, categoryName),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
                                onPressed: () => _handleDeleteCategory(categoryName),
                              ),
                            ],
                          ),
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