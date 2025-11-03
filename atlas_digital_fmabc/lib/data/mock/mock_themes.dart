import 'package:atlas_digital_fmabc/models/groups/theme_model.dart';
import 'package:atlas_digital_fmabc/models/image_model.dart';

final imagem1 = ImageModel(id: '1', nome: 'IMAGEM1', url: 'https://images.unsplash.com/photo-1761839258753-85d8eecbbc29?ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&q=80&w=1170');
final imagem2 = ImageModel(id: '2', nome: 'IMAGEM2', url: 'https://images.unsplash.com/photo-1761872936374-ec038c00d705?ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&q=80&w=1170');
final imagem3 = ImageModel(id: '3', nome: 'IMAGEM3', url: 'https://images.unsplash.com/photo-1760644520246-e84fadc18cd6?ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&q=80&w=1170');
final imagem4 = ImageModel(id: '4', nome: 'IMAGEM4', url: 'https://images.unsplash.com/photo-1761995912979-c3646524391b?ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&q=80&w=764');

/// Exemplo de temas.
final List<ThemeModel> mockThemes = [
  ThemeModel(id:'1', name: "Epitélio", quantSlides: 10, listaDeImagens: [imagem1, imagem2, imagem3, imagem4]),
  ThemeModel(id:'2',name: "Tecido Conjuntivo", quantSlides: 8, listaDeImagens: [imagem2, imagem4]),
  ThemeModel(id:'3',name: "Músculo", quantSlides: 12, listaDeImagens: [imagem3]),
  ThemeModel(id:'4',name: "Cartilagem e Osso", quantSlides: 15, listaDeImagens: []),
  ThemeModel(id:'5',name: "Tecido Nervoso", quantSlides: 9, listaDeImagens: []),
  ThemeModel(id:'6',name: "Sangue Periférico", quantSlides: 11, listaDeImagens: []),
  ThemeModel(id:'7',name: "Hematopoiese", quantSlides: 7, listaDeImagens: []),
  ThemeModel(id:'8',name: "Sistema Cardiovascular", quantSlides: 6, listaDeImagens: []),
  ThemeModel(id:'9',name: "Sistema Linfoide", quantSlides: 5, listaDeImagens: []),
  ThemeModel(id:'10',name: "Pele", quantSlides: 14, listaDeImagens: []),
  ThemeModel(id:'11',name: "Glândulas Exócrinas", quantSlides: 4, listaDeImagens: []),
  ThemeModel(id:'12',name: "Glândulas Endócrinas", quantSlides: 3, listaDeImagens: []),
  ThemeModel(id:'13',name: "Trato Gastrointestinal", quantSlides: 13, listaDeImagens: []),
  ThemeModel(id:'14',name: "Fígado e Vesícula Biliar", quantSlides: 10, listaDeImagens: []),
  ThemeModel(id:'15',name: "Sistema Urinário", quantSlides: 8, listaDeImagens: []),
  ThemeModel(id:'16',name: "Sistema Respiratório", quantSlides: 9, listaDeImagens: []),
  ThemeModel(id:'17',name: "Sistema Reprodutor Feminino", quantSlides: 12, listaDeImagens: []),
  ThemeModel(id:'18',name: "Sistema Reprodutor Masculino", quantSlides: 11, listaDeImagens: []),
];
