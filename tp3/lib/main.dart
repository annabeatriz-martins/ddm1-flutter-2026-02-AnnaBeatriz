import 'package:flutter/material.dart';
//Anna Beatriz Martins da Silva
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Turismo Baixada Santista - Anna Beatriz',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TuristicoHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}