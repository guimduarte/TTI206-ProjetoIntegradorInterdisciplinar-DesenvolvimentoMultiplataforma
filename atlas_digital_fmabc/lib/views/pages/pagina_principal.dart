import 'package:atlas_digital_fmabc/models/categoria_model.dart';
import 'package:flutter/material.dart';

class PaginaPrincipal extends StatelessWidget {
  final List<CategoriaModel> categoriasLista; // ADICIONAR 'FINAL' DEPOIS AQUI.
  PaginaPrincipal({required this.categoriasLista}); //isto é o construtor deste widget. Ele deve aceitar uma lista de objetos do tipo "CategoriaModel". O "required" indica que esse parâmetro é obrigatório.

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: GridView.builder(
        itemCount: categoriasLista.length,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200, // 2 colunas
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1, // proporção da imagem (largura/altura)
            ), 
        itemBuilder: (context, index) {
          final categoriaAtual = categoriasLista[index];
      
          return Material(
            borderRadius: BorderRadius.circular(12), // para ripple respeitar bordas arredondadas
            child: InkWell(
              borderRadius: BorderRadius.circular(12), // mesma borda para ripple
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (_) => PaginaDetalhes(imagemUrl: imageUrl),
                //   ),
                // );
                print('clique em ${categoriaAtual.nomeCategoria}');
              },
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                clipBehavior: Clip.antiAlias,
                child: 
                  // Image.network(
                  //   imageUrl,
                  //   fit: BoxFit.cover,
                  //   width: double.infinity,
                  //   height: double.infinity,
                  // ),
                  Text(categoriaAtual.nomeCategoria)
              ),
            ),
          );
        }
      ),
    );
  }
}