import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  // Estado para controlar a visibilidade da senha no campo de cadastro
  bool _obscurePassword = true; 

  // Controladores de Texto para a seção de Criação de Temas
  final TextEditingController _temaController = TextEditingController();
  final List<String> temas = [];
  final List<String> imagens = [];

  // 👨‍🏫 Controladores de Texto para a seção de Cadastro de Professores
  final TextEditingController _nomeProfessorController = TextEditingController();
  final TextEditingController _emailProfessorController = TextEditingController();
  final TextEditingController _senhaProfessorController = TextEditingController();

  // ⚠️ VARIÁVEIS PARA CARREGAR DADOS DO BACKEND
  List<Map<String, String>> professores = []; // Lista para armazenar professores
  bool _isLoading = true; // Estado para o carregamento inicial

  @override
  void initState() {
    super.initState();
    _fetchProfessores(); // Inicia a busca pelos professores ao carregar a página
  }

  Future<void> _fetchProfessores() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final url = Uri.parse('mongo'); 
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        
        professores = jsonList.map((item) {
            // Garante que 'nome' e 'email' existem ou usa uma string vazia como fallback
            return {
              'nome': item['nome']?.toString() ?? 'Nome Indisponível',
              'email': item['email']?.toString() ?? 'Email Indisponível',
              // Não armazena ou exibe a senha real
            };
        }).toList();

      } else {
        print('Erro ao carregar professores: ${response.statusCode}');
        // Simulação de dados em caso de falha de conexão para demonstração
         professores = [
            {'nome': 'Falha Conexão', 'email': 'Verifique a API'},
            {'nome': 'Mock Data', 'email': 'Simulação Ativa'},
         ];
      }
    } catch (e) {
      print('Erro de conexão ou parse: $e');
      // Simulação de dados em caso de erro
      professores = [
            {'nome': 'Erro de Rede', 'email': 'Verifique o localhost (10.0.2.2:3000)'},
       ];
    } finally {
      setState(() {
        _isLoading = false; // Finaliza o carregamento
      });
    }
  }

  // Novo método para lidar com o cadastro do professor (Simulando um POST e recarregando)
  void _cadastrarProfessor() {
    final nome = _nomeProfessorController.text.trim();
    final email = _emailProfessorController.text.trim();
    final senha = _senhaProfessorController.text.trim();

    if (nome.isNotEmpty && email.isNotEmpty && senha.isNotEmpty) {
      // ⚠️ Em uma aplicação real, aqui você faria uma chamada http.post
      // Após o sucesso do POST, você chamaria _fetchProfessores()
      
      // Limpa os campos após o cadastro
      _nomeProfessorController.clear();
      _emailProfessorController.clear();
      _senhaProfessorController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Professor(a) $nome cadastrado(a) com sucesso! (POST simulado)')),
      );

      // Atualiza a lista para refletir o "novo" professor (em um app real seria via _fetchProfessores)
      // Neste caso, vou apenas recarregar os dados do mock/backend
      _fetchProfessores();

    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preencha todos os campos para cadastrar o professor.')),
      );
    }
  }

  // Método para criar um Card de Seção
  Widget _buildSectionCard({required String title, required List<Widget> children}) {
    return Card(
      elevation: 4, 
      margin: const EdgeInsets.only(bottom: 24), 
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), 
      ),
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

  // Novo método para isolar a lógica do diálogo de edição
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
              onPressed: () => Navigator.pop(
                  context, controller.text.trim()),
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
    // Liberar controladores
    _temaController.dispose();
    _nomeProfessorController.dispose();
    _emailProfessorController.dispose();
    _senhaProfessorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              // 👨‍🏫 SEÇÃO: Cadastro de Novos Professores
              _buildSectionCard(
                title: "Cadastro de Novos Professores",
                children: [
                  TextField(
                    controller: _nomeProfessorController,
                    decoration: const InputDecoration(
                      labelText: "Nome Completo",
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _emailProfessorController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: "E-mail",
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Campo de Senha com alternância de visibilidade
                  TextField(
                    controller: _senhaProfessorController,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      labelText: "Senha",
                      hintText: "Senha",
                      prefixIcon: const Icon(Icons.lock),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off 
                              : Icons.visibility,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: _cadastrarProfessor,
                    icon: const Icon(Icons.person_add),
                    label: const Text("Cadastrar Professor"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Theme.of(context).colorScheme.onPrimary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      minimumSize: const Size(double.infinity, 50),
                    ),
                  ),
                ],
              ),

              // SEÇÃO: Lista de Professores (COM CARREGAMENTO DA API)
              _buildSectionCard(
                title: "Professores Cadastrados (${professores.length})",
                children: [
                  _isLoading 
                  ? const Center(child: CircularProgressIndicator()) // Indicador de carregamento
                  : professores.isEmpty
                      ? const Center(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("Nenhum professor encontrado. Tente recarregar ou verifique a API."),
                          ),
                        )
                      : Column(
                          children: professores.map((professor) {
                            return ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: const Icon(Icons.school, color: Colors.blueGrey),
                              title: Text(professor['nome']!),
                              subtitle: Text(professor['email']!),
                              trailing: IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
                                // Em um app real, faria um http.delete e chamaria _fetchProfessores()
                                onPressed: () {
                                  setState(() {
                                    professores.remove(professor);
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Professor ${professor['nome']} removido (Simulado).')),
                                  );
                                },
                              ),
                            );
                          }).toList(),
                        ),
                  // Botão de recarregar
                  if (!_isLoading) 
                    TextButton.icon(
                      onPressed: _fetchProfessores,
                      icon: const Icon(Icons.refresh),
                      label: const Text("Recarregar Lista"),
                    ),
                ],
              ),
              
              // SEÇÃO: Upload de Imagens (Mantida)
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
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children:
                        imagens.map((img) => Chip(label: Text(img))).toList(),
                  ),
                ],
              ),


              //  SEÇÃO: Criação de Temas (Mantida)
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
                      foregroundColor: Theme.of(context).colorScheme.onSecondary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      minimumSize: const Size(double.infinity, 48),
                    ),
                  ),
                ],
              ),

              // SEÇÃO: Edição/Lista de Temas (Mantida)
              _buildSectionCard(
                title: "Temas Criados",
                children: temas.isEmpty
                    ? [
                        const Center(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text("Nenhum tema criado ainda."),
                            ),
                          )
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
                                    icon: const Icon(Icons.edit, color: Colors.blue),
                                    onPressed: () => _showEditDialog(index, tema),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete, color: Colors.red),
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