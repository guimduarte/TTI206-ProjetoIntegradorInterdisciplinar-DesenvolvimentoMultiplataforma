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
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            SizedBox(height: 8.0),
            // Imagem
            ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(12.0),
              child: AspectRatio(
                aspectRatio: 21 / 9,
                child: Image.asset(
                  "assets/images/bg/login-bg.jpg",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
