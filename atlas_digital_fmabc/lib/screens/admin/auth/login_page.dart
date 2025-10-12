import 'package:atlas_digital_fmabc/data/constants/constants.dart';
import 'package:atlas_digital_fmabc/widgets/form/login_form.dart';
import 'package:atlas_digital_fmabc/widgets/layout/app_bar/title_and_supporting_text.dart';
import 'package:atlas_digital_fmabc/widgets/logo/logo.dart';
import 'package:flutter/material.dart';

/// Página de login para professores.
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    const imagePath = "assets/images/bg/login-bg.jpg";

    final width = MediaQuery.of(context).size.width;
    final isDesktop = width > KBreakpoints.md;

    /// AppBar da página de login.
    final appBar = AppBar(
      centerTitle: true,
      title: const TitleAndSupportingText(
        title: "Entrar como Professor",
        supportingText: "FMABC | Atlas Digital de Biologia Tecidual",
      ),
    );

    /// Conteúdo principal da página de login.
    final mainContent = Column(
      children: [
        // Form de login
        LoginForm(),
        // Logo da FMABC
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 96, vertical: 4),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 64.0),
            child: Logo(),
          ),
        ),
      ],
    );

    /// Página de login para mobile.
    final mobilePage = Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            SizedBox(height: 10.0),
            // Imagem
            ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(12.0),
              child: AspectRatio(
                aspectRatio: 21 / 9,
                child: Image.asset(imagePath, fit: BoxFit.cover),
              ),
            ),

            mainContent,
          ],
        ),
      ),
    );

    /// Página de login para desktop.
    final desktopPage = Row(
      children: [
        Expanded(
          flex: (width < KBreakpoints.lg) ? 2 : 1,
          child: Scaffold(
            appBar: appBar,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: mainContent,
            ),
          ),
        ),
        // Imagem lateral
        Expanded(
          child: Image.asset(
            imagePath,
            fit: BoxFit.cover,
            height: double.infinity,
          ),
        ),
      ],
    );

    return isDesktop ? desktopPage : mobilePage;
  }
}
