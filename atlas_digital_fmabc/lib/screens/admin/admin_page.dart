import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:atlas_digital_fmabc/widgets/form/cadastro_form.dart';
import 'package:atlas_digital_fmabc/services/auth_service.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final AuthService _authService = AuthService();

  final TextEditingController _temaController = TextEditingController();
  final List<String> temas = [];
  final List<String> imagens = [];

  // VARIÁVEIS PARA CARREGAR DADOS DO BACKEND
  List<Map<String, dynamic>> usuarios = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchProfessores();
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
          'email': 'Não foi possível conectar a localhost:8000/users',
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

  // Método para isolar a lógica do diálogo de edição de temas
  void _showEditDialog(int index, String tema) async {
    String? novoTema = await showDialog<String>(
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
              onPressed: () => Navigator.pop(context, controller.text.trim()),
              child: const Text("Salvar"),
            ),
          ],
        );
      },
    );
    if (novoTema != null && novoTema.isNotEmpty && novoTema != tema) {
      setState(() {
        temas[index] = novoTema;
      });
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // SEÇÃO DE CADASTRO
              _buildSectionCard(
                title: "Cadastro de Novos Usuários",
                children: [CadastroForm(onCadastroSuccess: _fetchProfessores)],
              ),

              // SEÇÃO: Lista de usuarios
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
                                color: isAdmin ? Colors.deepOrange : Colors.blueGrey,
                              ),
                              title: Text(user['nome']!),
                              subtitle: Text(userEmail),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // Chip 
                                  Chip(
                                    label: Text(isAdmin ? "Admin":"Professor"),
                                    backgroundColor: isAdmin ? Colors.deepOrange.shade100 : Colors.blue.shade100,
                                    labelStyle: TextStyle(
                                      color: isAdmin ? Colors.deepOrange.shade900 : Colors.blue.shade900,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10,
                                    ),
                                  ),
                                  const SizedBox(width: 8),

                                  //LIXEIRA
                                  IconButton(
                                    icon: Icon(
                                      Icons.delete,
                                      color: isAdmin?Colors.grey:Colors.red,
                                    ),
                                    onPressed: isAdmin ? null : () async {
                                      setState(() {
                                        _isLoading = true;
                                      });
                                      final resultado = await _authService
                                          .deleteUser(email: userEmail);

                                      if (resultado.containsKey('success')) {
                                        // SnackBar de sucesso
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text(resultado['message']),
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

              //  SEÇÃO: Criação de Temas
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
                      hintText: "Ex: Natureza, Cidades, Arte",
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      if (_temaController.text.isNotEmpty &&
                          !temas.contains(_temaController.text.trim())) {
                        setState(() {
                          temas.add(_temaController.text.trim());
                          _temaController.clear();
                        });
                      }
                    },
                    child: const Text("Criar Tema"),
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

              // SEÇÃO: Edição/Lista de Temas
              _buildSectionCard(
                title: "Temas Criados",
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
                                    icon: const Icon(
                                      Icons.edit,
                                      color: Colors.blue,
                                    ),
                                    onPressed: () =>
                                        _showEditDialog(index, tema),
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
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
