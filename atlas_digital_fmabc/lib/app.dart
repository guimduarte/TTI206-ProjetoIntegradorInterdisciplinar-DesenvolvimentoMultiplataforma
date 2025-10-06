import 'package:atlas_digital_fmabc/screens/home/home_page.dart';
import 'package:flutter/material.dart';
import "core/themes/theme.dart";

class App extends StatelessWidget {
  const App({super.key});

  /// Root Widget da aplicação.
  @override
  Widget build(BuildContext context) {
    /// Tema do app.
    final materialTheme = MaterialTheme(ThemeData.light().textTheme);

    return MaterialApp(
      title: 'Atlas Digital FMABC', // título do app
      theme: materialTheme.light(), // tema claro
      darkTheme: materialTheme.dark(), // tema escuro
      debugShowCheckedModeBanner: false, // remover banner de "debug"
      home: const HomePage(), // página inicial
    );
  }
}
