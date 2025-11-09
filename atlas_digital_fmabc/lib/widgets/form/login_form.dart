import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:atlas_digital_fmabc/services/auth_service.dart';
import 'package:go_router/go_router.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  String _email = "";
  String _senha = "";
  final AuthService _authService = AuthService();

  bool _isLoading = false;
  bool _obscurePassword = true;
  bool rememberMe = false;

  Future<void> _handleLogin() async {
    if (_email.isEmpty || _senha.isEmpty) {
      _showSnackBar('Por favor, insira seu e-mail e senha.', isError: true);
      return;
    }

    if (!mounted) return;
    setState(() => _isLoading = true);

    final String? error = await _authService.login(
      email: _email,
      password: _senha,
    );

    if (!mounted) return;
    setState(() => _isLoading = false);

    if (error == null) {
      // Espera 100ms antes de navegar (corrige o bug do Flutter Web)
      Future.delayed(const Duration(milliseconds: 100), () {
        if (mounted) {
          context.go('/professorArea');
        }
      });

      // Mostra feedback visual após o login
      _showSnackBar('Login bem-sucedido!', isError: false);
    } else {
      _showSnackBar(error, isError: true);
    }
  }

  void _showSnackBar(String message, {required bool isError}) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red.shade700 : Colors.green.shade700,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fieldBorder =
        OutlineInputBorder(borderRadius: BorderRadius.circular(12.0));

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text("Bem-vindo de volta",
              style: theme.textTheme.displaySmall,
              textAlign: TextAlign.center),
          const SizedBox(height: 20.0),

          TextField(
            onChanged: (valor) => setState(() => _email = valor),
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              border: fieldBorder,
              labelText: "E-mail",
              hintText: "E-mail institucional (@fmabc.net)",
              prefixIcon: const Icon(FluentIcons.mail_32_regular),
            ),
          ),
          const SizedBox(height: 20.0),

          TextField(
            onChanged: (valor) => setState(() => _senha = valor),
            keyboardType: TextInputType.visiblePassword,
            obscureText: _obscurePassword,
            decoration: InputDecoration(
              border: fieldBorder,
              labelText: "Senha",
              hintText: "Senha",
              prefixIcon: const Icon(FluentIcons.key_32_regular),
              suffixIcon: IconButton(
                onPressed: () =>
                    setState(() => _obscurePassword = !_obscurePassword),
                icon: Icon(_obscurePassword
                    ? FluentIcons.eye_off_32_regular
                    : FluentIcons.eye_32_regular),
              ),
            ),
          ),
          const SizedBox(height: 10.0),

          SwitchListTile(
            title: const Text("Manter-me conectado"),
            subtitle: const Text(
                "Salva sua sessão para entrar automaticamente na próxima vez"),
            value: rememberMe,
            onChanged: (value) => setState(() => rememberMe = value),
          ),
          const SizedBox(height: 20.0),

          Row(
            children: [
              Expanded(
                child: FilledButton.icon(
                  onPressed: _isLoading ? null : _handleLogin,
                  label: _isLoading
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                              strokeWidth: 2.0, color: Colors.white),
                        )
                      : const Text("Entrar"),
                  icon: _isLoading
                      ? const SizedBox.shrink()
                      : const Icon(FluentIcons.arrow_enter_20_filled),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
