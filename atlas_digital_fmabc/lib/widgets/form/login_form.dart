import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:atlas_digital_fmabc/services/auth_service.dart'; 

/// Formulário de login.
class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService(); 

  bool _isLoading = false;      
  bool _obscurePassword = true; 
  bool rememberMe = false;      
  

  void _handleLogin() async {
    final String email = _emailController.text;
    final String password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      _showSnackBar('Por favor, insira seu e-mail e senha.', isError: true);
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // 3. Call the Backend API
    final String? error = await _authService.login(
      email: email,
      password: password,
    );


    setState(() {
      _isLoading = false;
    });


    if (error == null) {
      // Login successful!
      _showSnackBar('Login bem-sucedido!', isError: false);
      _navigateToHome();
    } else {

      _showSnackBar(error, isError: true);
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

  void _navigateToHome() {

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const Text('Success! Navigate to Home Screen'), 
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final fieldBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0),
    );

    final emailField = TextField(
      controller: _emailController, 
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        border: fieldBorder,
        labelText: "E-mail",
        hintText: "E-mail institucional (@fmabc.net)",
        prefixIcon: Icon(FluentIcons.mail_32_regular),
      ),
    );

    final passwordField = TextField(
      controller: _passwordController, 
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
            onPressed: _isLoading ? null : _handleLogin,
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
            icon: _isLoading ? const SizedBox.shrink() : const Icon(FluentIcons.arrow_enter_20_filled),
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
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}