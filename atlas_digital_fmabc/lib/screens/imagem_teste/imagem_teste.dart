 import 'package:atlas_digital_fmabc/common/widgets/cards/image_visualizer.dart';
import 'package:flutter/material.dart';

/// Página de itens salvos.
class TesteImagem extends StatelessWidget {
  const TesteImagem({super.key}); // Construtor padrão

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // layout
      appBar: _savedAppBar(context),
      // conteúdo
      body: 
          SafeArea(child: ImageVisualizer(imageName: "Mirax2.2-4-PNG",))
      
    );
  }

  /// AppBar da página inicial.
  AppBar _savedAppBar(BuildContext context) {
    final theme = Theme.of(context);
    return AppBar(
      // aparência
      backgroundColor: theme.colorScheme.primary,
      foregroundColor: theme.colorScheme.onPrimary,
      // título da página
      title: Text(
        "Imagem Teste",
        style: theme.textTheme.headlineMedium?.copyWith(
          color: theme.colorScheme.onPrimary,
        ),
      ),
      centerTitle: true,
    );
  }
}
