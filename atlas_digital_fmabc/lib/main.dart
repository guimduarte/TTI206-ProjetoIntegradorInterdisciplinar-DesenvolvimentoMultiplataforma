/*import 'package:flutter/material.dart';
import "app.dart";

void main() {
  runApp(const App());
}*/
 


// Teste area do professor
import 'package:flutter/material.dart';
import 'screens/professor_area/professor_area.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProfessorArea(), 
    );
  }
}
