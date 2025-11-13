import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; 
import 'dart:convert';
import 'package:atlas_digital_fmabc/services/auth_service.dart';

// Defina a assinatura do callback para notificar a AdminPage
typedef OnCadastroSuccess = void Function();

class CadastroForm extends StatefulWidget {
  final OnCadastroSuccess onCadastroSuccess;

  const CadastroForm({super.key, required this.onCadastroSuccess});

  @override
  State<CadastroForm> createState() => _CadastroFormState();
}

class _CadastroFormState extends State<CadastroForm> {
  // Instância do serviço de autenticação
  final AuthService _authService = AuthService();

  // Controladores de Texto
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  // Estado
  bool _obscurePassword = true;
  bool _isSaving = false;
  bool _isAdmin = false; // Define o tipo de usuário (Admin ou Professor)

  @override
  void dispose() {
    _nomeController.dispose();
    _emailController.dispose();
    _senhaController.dispose();
    super.dispose();
  }

  void _showSnackBar(String message, {required bool isError}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red.shade700 : Colors.green.shade700,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  Future<void> _handleCadastro() async {
    final nome = _nomeController.text.trim();
    final email = _emailController.text.trim();
    final senha = _senhaController.text.trim();

    // Mapeia o estado booleano para a string 'tipo' esperada pelo backend
    final userType = _isAdmin ? "admin" : "professor";

    if (nome.isEmpty || email.isEmpty || senha.isEmpty) {
      _showSnackBar(
        'Preencha todos os campos para cadastrar o usuário.',
        isError: true,
      );
      return;
    }

    setState(() {
      _isSaving = true;
    });

    try {
      final Map<String, dynamic> resultado = await _authService.register(
        nome: nome,
        email: email,
        senha: senha,
        userType: userType,
      );

      if (resultado.containsKey('success')) {
        // Sucesso
        _showSnackBar(resultado['message'], isError: false);

        
        _nomeController.clear();
        _emailController.clear();
        _senhaController.clear();
        setState(() {
          _isAdmin = false; 
        });

        widget.onCadastroSuccess();
      } else {
        // Erro
        _showSnackBar(
          resultado['message'] ?? 'Erro desconhecido.',
          isError: true,
        );
      }
    } catch (e) {
      _showSnackBar(
        'Erro de comunicação: Não foi possível completar o cadastro.',
        isError: true,
      );
    } finally {
      setState(() {
        _isSaving = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Campo Nome
        TextField(
          controller: _nomeController,
          decoration: const InputDecoration(
            labelText: "Nome Completo",
            prefixIcon: Icon(Icons.person),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Campo E-mail
        TextField(
          controller: _emailController,
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

        // Campo Senha
        TextField(
          controller: _senhaController,
          keyboardType: TextInputType.visiblePassword,
          obscureText: _obscurePassword,
          decoration: InputDecoration(
            labelText: "Senha",
            hintText: "Senha inicial",
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
                _obscurePassword ? Icons.visibility_off : Icons.visibility,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Seletor de Permissão (SwitchListTile)
        SwitchListTile(
          title: const Text(
            "Permissão de Administrador (Admin)",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            _isAdmin
                ? "O usuário terá acesso completo à Área do Admin."
                : "O usuário terá acesso restrito à Área do Professor.",
          ),
          value: _isAdmin,
          onChanged: (value) {
            setState(() {
              _isAdmin = value;
            });
          },
        ),

        const SizedBox(height: 24),

        // Botão de Cadastro
        ElevatedButton.icon(
          onPressed: _isSaving ? null : _handleCadastro,
          icon: _isSaving
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.0,
                    color: Colors.white,
                  ),
                )
              : const Icon(Icons.person_add),
          label: Text(_isSaving ? "Cadastrando..." : "Cadastrar Usuário"),
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
    );
  }
}
