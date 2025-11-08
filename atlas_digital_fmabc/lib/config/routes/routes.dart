// Lista de rotas principais da aplicação.
class Routes {
  Routes._();
  // Rotas principais
  static const String homePage = "/";
  static const String slidesPage = "/laminas";
  static const String savedItens = "/salvos";
  static const String menuPage = "/menu";

  // Rotas admin
  static const String loginPage = "login";
  static const String nestedLoginPage = "/menu/login";
  static const String adminPage = "/admin";
  static const String professorPage = "/professor";

  //Rota da imagem teste
  static const String imagemTeste = "teste";
  static const String nestedImagemPage = "/menu/teste";
}
