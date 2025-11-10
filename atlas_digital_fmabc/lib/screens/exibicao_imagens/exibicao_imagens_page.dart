import 'package:atlas_digital_fmabc/common/widgets/cards/image_visualizer.dart';
import 'package:atlas_digital_fmabc/models/image_model.dart';
import 'package:flutter/material.dart';

class ExibicaoImagensPage extends StatelessWidget {

  final ImageModel imagem;

  const ExibicaoImagensPage({super.key, required this.imagem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // layout
      appBar: _savedAppBar(context),
      // conteúdo
      body:
LayoutBuilder(
  builder: (context, constraints) {
    final double screenHeight = MediaQuery.of(context).size.height;

    if (constraints.maxWidth < 600) {
      // 📱 Telas pequenas: empilha (imagem + texto) e tudo rola junto
      return SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              height: screenHeight * 0.5, // metade da tela visível
              child: ImageVisualizer(
                imageName: "Mirax2.2-4-PNG.mrxs-tiles",
              ),
            ),
            const SizedBox(height: 8),
            Text(
"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam vitae convallis metus. Fusce lectus tellus, mattis ut sagittis in, faucibus et sapien. Integer tincidunt ornare tincidunt. In ac lorem in nunc feugiat tincidunt sit amet ut nisl. Suspendisse fermentum, erat at fermentum congue, augue erat faucibus nulla, nec maximus mi justo ut risus. Sed auctor sem facilisis nulla efficitur, in semper lorem aliquet. Nam metus sapien, dapibus in erat sed, efficitur iaculis tortor. Proin sollicitudin, odio sed posuere sagittis, diam arcu eleifend ex, vel laoreet justo tellus ut eros. Praesent convallis, risus vel pharetra pretium, ipsum lectus vehicula lectus, molestie consequat eros magna sed lectus. Etiam nec elit nunc. Fusce suscipit mollis nisl, faucibus ornare dui viverra eu. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Nulla at mattis sapien. Mauris pellentesque a purus ut efficitur. Praesent quis lacus vitae risus dapibus tempus sed eu ante. Curabitur posuere, eros ac molestie lacinia, dolor tellus maximus nisl, nec luctus leo purus sed velit. Fusce tincidunt condimentum tellus, a venenatis lacus elementum vel. Integer varius nec ligula in congue. Fusce porta volutpat velit, non tincidunt lorem laoreet varius. Aliquam quis venenatis ante. Praesent finibus pretium diam, sit amet consectetur neque interdum ac. Nulla gravida sagittis luctus. Vivamus facilisis, ex ac vehicula eleifend, ipsum velit semper elit, vitae pharetra nisi ante nec nulla. Nam orci augue, scelerisque eget orci nec, ultricies elementum nulla. Integer cursus, velit eget rhoncus tincidunt, lectus ex semper elit, non pellentesque neque ante ac elit. Cras nec dignissim tellus. Nulla feugiat purus ac congue euismod. Phasellus ornare pretium purus. Curabitur in posuere elit. Sed tincidunt nisl non dapibus fermentum. Donec quis ligula at tellus pharetra euismod. Nullam vel est eros. Proin suscipit erat facilisis vehicula placerat. Nam ullamcorper turpis ultricies placerat volutpat. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Nulla facilisi. Donec finibus molestie sem ac volutpat. Nam hendrerit ipsum ultricies tortor bibendum, at pharetra velit auctor. Phasellus viverra augue ut turpis commodo, a tincidunt metus pharetra. Nam ultricies bibendum odio, nec pharetra ipsum placerat ut. Proin pellentesque lorem eros, quis fermentum orci sodales sagittis. Sed volutpat elementum enim eget venenatis. Aliquam maximus, ante vel elementum blandit, justo nunc euismod nisl, blandit faucibus eros quam consequat felis. Integer ut massa at quam placerat convallis. Pellentesque a tortor magna. Etiam nec pharetra mauris, ut vestibulum justo. Proin vitae bibendum ligula, vitae efficitur quam. Curabitur eu mollis massa, vitae eleifend arcu. Duis convallis vulputate ex, non imperdiet velit vulputate a. Donec in eros eget ligula lacinia ultricies. Vestibulum sit amet augue commodo, bibendum nisi in, maximus tellus. Vivamus condimentum enim et neque scelerisque, interdum ullamcorper lacus vulputate. Curabitur aliquet, nisi et finibus vestibulum, purus metus ullamcorper eros, quis sodales dolor eros et libero. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc sit amet ante in est tristique accumsan.",
              softWrap: true,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      );
    } else {
      // 🖥️ Telas grandes: imagem ocupa toda a altura, texto rola independente
      return Row(
        crossAxisAlignment: CrossAxisAlignment.stretch, // estica a imagem verticalmente
        children: [
          // imagem usa toda a altura da tela
          SizedBox(
            width: constraints.maxWidth * 0.7,
            height: screenHeight, // ocupa toda a altura visível
            child: ImageVisualizer(
              imageName: "Mirax2.2-4-PNG.mrxs-tiles",
            ),
          ),
          const SizedBox(width: 12),

          // texto rola à direita
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Scrollbar(
                thumbVisibility: true,
                child: SingleChildScrollView(
                  child: Text(
"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam vitae convallis metus. Fusce lectus tellus, mattis ut sagittis in, faucibus et sapien. Integer tincidunt ornare tincidunt. In ac lorem in nunc feugiat tincidunt sit amet ut nisl. Suspendisse fermentum, erat at fermentum congue, augue erat faucibus nulla, nec maximus mi justo ut risus. Sed auctor sem facilisis nulla efficitur, in semper lorem aliquet. Nam metus sapien, dapibus in erat sed, efficitur iaculis tortor. Proin sollicitudin, odio sed posuere sagittis, diam arcu eleifend ex, vel laoreet justo tellus ut eros. Praesent convallis, risus vel pharetra pretium, ipsum lectus vehicula lectus, molestie consequat eros magna sed lectus. Etiam nec elit nunc. Fusce suscipit mollis nisl, faucibus ornare dui viverra eu. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Nulla at mattis sapien. Mauris pellentesque a purus ut efficitur. Praesent quis lacus vitae risus dapibus tempus sed eu ante. Curabitur posuere, eros ac molestie lacinia, dolor tellus maximus nisl, nec luctus leo purus sed velit. Fusce tincidunt condimentum tellus, a venenatis lacus elementum vel. Integer varius nec ligula in congue. Fusce porta volutpat velit, non tincidunt lorem laoreet varius. Aliquam quis venenatis ante. Praesent finibus pretium diam, sit amet consectetur neque interdum ac. Nulla gravida sagittis luctus. Vivamus facilisis, ex ac vehicula eleifend, ipsum velit semper elit, vitae pharetra nisi ante nec nulla. Nam orci augue, scelerisque eget orci nec, ultricies elementum nulla. Integer cursus, velit eget rhoncus tincidunt, lectus ex semper elit, non pellentesque neque ante ac elit. Cras nec dignissim tellus. Nulla feugiat purus ac congue euismod. Phasellus ornare pretium purus. Curabitur in posuere elit. Sed tincidunt nisl non dapibus fermentum. Donec quis ligula at tellus pharetra euismod. Nullam vel est eros. Proin suscipit erat facilisis vehicula placerat. Nam ullamcorper turpis ultricies placerat volutpat. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Nulla facilisi. Donec finibus molestie sem ac volutpat. Nam hendrerit ipsum ultricies tortor bibendum, at pharetra velit auctor. Phasellus viverra augue ut turpis commodo, a tincidunt metus pharetra. Nam ultricies bibendum odio, nec pharetra ipsum placerat ut. Proin pellentesque lorem eros, quis fermentum orci sodales sagittis. Sed volutpat elementum enim eget venenatis. Aliquam maximus, ante vel elementum blandit, justo nunc euismod nisl, blandit faucibus eros quam consequat felis. Integer ut massa at quam placerat convallis. Pellentesque a tortor magna. Etiam nec pharetra mauris, ut vestibulum justo. Proin vitae bibendum ligula, vitae efficitur quam. Curabitur eu mollis massa, vitae eleifend arcu. Duis convallis vulputate ex, non imperdiet velit vulputate a. Donec in eros eget ligula lacinia ultricies. Vestibulum sit amet augue commodo, bibendum nisi in, maximus tellus. Vivamus condimentum enim et neque scelerisque, interdum ullamcorper lacus vulputate. Curabitur aliquet, nisi et finibus vestibulum, purus metus ullamcorper eros, quis sodales dolor eros et libero. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc sit amet ante in est tristique accumsan.",
                    softWrap: true,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    }
  },
)

    );
  }
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