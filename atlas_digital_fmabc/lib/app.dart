import 'package:atlas_digital_fmabc/config/routes/router.dart';
import 'package:flutter/material.dart';

import "utils/themes/theme.dart";

class App extends StatelessWidget {
  const App({super.key});

  /// Root Widget da aplicação.
  @override
  Widget build(BuildContext context) {
    /// Tema do app.
    final materialTheme = MaterialTheme(ThemeData.light().textTheme);

    return MaterialApp.router(
      title: 'Atlas Digital FMABC', // título do app

      theme: materialTheme.light(), // tema claro
      darkTheme: materialTheme.dark(), // tema escuro

      debugShowCheckedModeBanner: false, // remover banner de "debug"

      routerConfig: router, // configuração do roteador
    );
  }
}
