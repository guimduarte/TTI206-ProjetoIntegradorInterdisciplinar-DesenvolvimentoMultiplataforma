import 'package:atlas_digital_fmabc/common/widgets/layout/app_bar/title_and_supporting_text.dart';
import 'package:atlas_digital_fmabc/models/groups/group_model.dart';
import 'package:atlas_digital_fmabc/models/image_model.dart';
import 'package:atlas_digital_fmabc/services/category_service.dart';
import 'package:atlas_digital_fmabc/utils/constants/image_strings.dart';
import 'package:atlas_digital_fmabc/widgets/lists/group_list.dart';
import 'package:atlas_digital_fmabc/widgets/lists/image_list.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

/// Página inicial da aba lâminas.
/// Exibe uma caixa de pesquisa e os temas de lâminas.
class ExploreSlidesPage extends StatefulWidget {
  const ExploreSlidesPage({super.key});

  @override
  State<ExploreSlidesPage> createState() => _ExploreSlidesPageState();
}

class _ExploreSlidesPageState extends State<ExploreSlidesPage> {
  final categoryService = CategoryService();

  // Variável que controla qual grupo (de imagens ou temas) mostrar
  GroupModel? selectedGroup;
  String? selectedGroupName;
  String _query = "";
  List<ImageModel> _filteredSlides = [];
  final List<ImageModel> _allSlides = [];
  bool _loading = true;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, //número de abas
      child: Scaffold(
        //layout
        appBar: _slidesAppBar(context),
        //conteúdo
        body: Column(
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(KImages.microscope02),
                  fit: BoxFit.cover,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 44.0,
                ),
                child: Center(
                  child: SearchBar(
                    hintText: "Pesquisar lâminas",
                    trailing: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(FluentIcons.search_24_filled),
                      ),
                    ],
                    onChanged: (newQuery) => setState(() {
                      if (!_loading) {
                        _query = newQuery;
                        _filteredSlides = _allSlides
                            .where(
                              (slide) => slide.nome.toLowerCase().contains(
                                newQuery.toLowerCase(),
                              ),
                            )
                            .toList();
                      }
                    }),
                  ),
                ),
              ),
            ),
            TabBar(
              tabs: [
                Tab(text: "Temas"),
                Tab(text: "Turmas"),
              ],
            ),
            FutureBuilder(
              future: categoryService.getCategories(),
              builder: (context, asyncSnapshot) {
                if (asyncSnapshot.hasData) {
                  final themesList = asyncSnapshot.data!;
                  _loading = false;
                  Set<String> imageNames = {};
                  _allSlides.clear();
                  for (var theme in themesList) {
                    for (var image in theme.listaDeImagens) {
                      if (!imageNames.contains(image.nome)) {
                        _allSlides.add(image);
                        imageNames.add(image.nome);
                      }
                    }
                  }
                  return Expanded(
                    child: TabBarView(
                      children: [
                        // Aba Temas
                        if (_query.trimLeft().trimRight() != "")
                          Expanded(
                            child: ImageList(listaDeImagens: _filteredSlides),
                          )
                        else if (selectedGroup == null)
                          GroupList(
                            listaDeGrupos: themesList,
                            onCardTap: (group) async {
                              await Future.delayed(
                                const Duration(milliseconds: 100),
                              );
                              setState(() {
                                selectedGroup = group;
                                selectedGroupName = group.name;
                              });
                            },
                          )
                        else
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              children: [
                                // Cabeçalho do grupo escolhido
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10.0,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(
                                      0xFFF2F2F2,
                                    ), // fundo da faixa
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      // Texto centralizado na tela
                                      Text(
                                        selectedGroupName!,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(
                                            255,
                                            129,
                                            129,
                                            129,
                                          ),
                                          fontSize: 18,
                                        ),
                                      ),

                                      // Botão de voltar
                                      Positioned(
                                        left: 8,
                                        child: ElevatedButton(
                                          onPressed: () async {
                                            await Future.delayed(
                                              const Duration(milliseconds: 80),
                                            );
                                            setState(() {
                                              selectedGroup = null;
                                            });
                                          },
                                          child: const Text("Voltar"),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                // Lista dos cards das imagens
                                Expanded(
                                  child: ImageList(
                                    listaDeImagens:
                                        selectedGroup!.listaDeImagens,
                                  ),
                                ),
                              ],
                            ),
                          ),

                        // Aba Turmas
                        Text("Turmas"),
                      ],
                    ),
                  );
                } else if (asyncSnapshot.hasError) {
                  return Text("Houve um erro");
                } else {
                  return Text("Carregando");
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  //AppBar da página de lâminas
  AppBar _slidesAppBar(BuildContext context) {
    final theme = Theme.of(context);
    return AppBar(
      //Aparência
      backgroundColor: theme.colorScheme.primary,
      foregroundColor: theme.colorScheme.onPrimary,
      //título da página
      title: TitleAndSupportingText(
        title: "Explorar Lâminas",
        supportingText: "FMABC | Atlas Digital de Biologia Tecidual",
        color: theme.colorScheme.onPrimary,
      ),
      centerTitle: true,
    );
  }
}
