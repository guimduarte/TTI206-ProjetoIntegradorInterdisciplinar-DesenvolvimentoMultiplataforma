import 'package:flutter/material.dart';

/// Imagem com a logo da FMABC. Variações de cores para diferentes fundos.
class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    const colorfulFile = "logo_fmabc.png";
    const whiteFile = "logo_fmabc_white.png";

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final fileName = isDark ? whiteFile : colorfulFile;

    return Image.asset("assets/images/logo/$fileName");
  }
}
