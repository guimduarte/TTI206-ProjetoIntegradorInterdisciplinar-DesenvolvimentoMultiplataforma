import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:atlas_digital_fmabc/services/auth_service.dart';
import 'package:go_router/go_router.dart';

/// Formulário de login.
class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late String _email;
  late String _senha;
  final AuthService _authService = AuthService();

  bool _isLoading = false;
  bool _obscurePassword = true;
  bool rememberMe = false;

  @override
  void initState() {
    _email = "";
    _senha = "";
  }

  void _handleLogin(BuildContext context) async {
    if (_email.isEmpty || _senha.isEmpty) {
      _showSnackBar('Por favor, insira seu e-mail e senha.', isError: true);
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // 3. Call the Backend API
    final Map<String, dynamic> resultado = await _authService.login(
      email: _email,
      password: _senha,
    );

    setState(() {
      _isLoading = false;
    });

    if (!resultado.containsKey('error')) {
      // Login successful!
      _showSnackBar('Login bem-sucedido!', isError: false);
      _navigateToPage(context, resultado["is_admin"]!);
    } else {
      _showSnackBar(resultado['error']!, isError: true);
    }
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

  void _navigateToPage(BuildContext context, bool isAdmin) {
    if (isAdmin) {
      context.go("/admin");
    } else {
      context.go("/professor");
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final fieldBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0),
    );

    final emailField = TextField(
      onChanged: (valor) => setState(() {
        _email = valor;
      }),
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        border: fieldBorder,
        labelText: "E-mail",
        hintText: "E-mail institucional (@fmabc.net)",
        prefixIcon: Icon(FluentIcons.mail_32_regular),
      ),
    );

    final passwordField = TextField(
      onChanged: (valor) => setState(() {
        _senha = valor;
      }),
      keyboardType: TextInputType.visiblePassword,
      obscureText: _obscurePassword,
      decoration: InputDecoration(
        border: fieldBorder,
        labelText: "Senha",
        hintText: "Senha",
        prefixIcon: Icon(FluentIcons.key_32_regular),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              _obscurePassword = !_obscurePassword;
            });
          },
          icon: Icon(
            _obscurePassword
                ? FluentIcons.eye_off_32_regular
                : FluentIcons.eye_32_regular,
          ),
        ),
      ),
    );

    final rememberMeSwitch = SwitchListTile(
      title: Text("Manter-me conectado"),
      subtitle: Text(
        "Salva sua sessão para entrar automaticamente na próxima vez",
      ),
      value: rememberMe,
      onChanged: (value) => setState(() {
        rememberMe = value;
      }),
    );

    final submitButton = Row(
      children: [
        Expanded(
          child: FilledButton.icon(
            onPressed: () => _isLoading ? null : _handleLogin(context),
            label: _isLoading
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.0,
                      color: Colors.white,
                    ),
                  )
                : const Text("Entrar"),
            icon: _isLoading
                ? const SizedBox.shrink()
                : const Icon(FluentIcons.arrow_enter_20_filled),
          ),
        ),
      ],
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Título
          Text(
            "Bem-vindo de volta",
            style: theme.textTheme.displaySmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20.0),

          emailField,
          const SizedBox(height: 20.0),
          passwordField,

          const SizedBox(height: 10.0),
          rememberMeSwitch,

          const SizedBox(height: 20.0),
          submitButton,
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
