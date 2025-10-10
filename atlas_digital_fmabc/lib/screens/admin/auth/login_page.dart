import 'package:atlas_digital_fmabc/widgets/layout/app_bar/title_and_supporting_text.dart';
import 'package:flutter/material.dart';

/// Página de login para professores.
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    /// AppBar da página de login.
    final appBar = AppBar(
      centerTitle: true,
      title: const TitleAndSupportingText(
        title: "Entrar como Professor",
        supportingText: "FMABC | Atlas Digital de Biologia Tecidual",
      ),
    );

    return Scaffold(
      appBar: appBar,
      body: Center(child: Text("Página de Login")),
    );
  }
}
