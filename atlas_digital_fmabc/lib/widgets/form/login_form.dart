import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

/// Formulário de login.
class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  /// Valor do campo lembre-se de mim.
  bool rememberMe = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    /// Borda dos campos
    final fieldBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0),
    );

    /// Campo de e-mail.
    final emailField = TextField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        border: fieldBorder,
        labelText: "E-mail",
        hintText: "E-mail institucional (@fmabc.net)",
        prefixIcon: Icon(FluentIcons.mail_32_regular),
      ),
    );

    /// Campo de senha.
    final passwordField = TextField(
      keyboardType: TextInputType.visiblePassword,
      obscureText: true,
      decoration: InputDecoration(
        border: fieldBorder,
        labelText: "Senha",
        hintText: "Senha",
        prefixIcon: Icon(FluentIcons.key_32_regular),
        suffixIcon: IconButton(
          onPressed: () {
            // TODO: exibir e ocultar senha
          },
          icon: Icon(FluentIcons.eye_32_filled),
        ),
      ),
    );

    /// Switch de continuar logado.
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

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      child: Column(
        spacing: 20.0,
        children: [
          // Título
          Text("Bem-vindo de volta", style: theme.textTheme.displaySmall),

          // Campos
          emailField,
          passwordField,

          // Continuar logado
          rememberMeSwitch,
        ],
      ),
    );
  }
}
