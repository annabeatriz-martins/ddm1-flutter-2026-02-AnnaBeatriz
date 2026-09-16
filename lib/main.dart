import 'package:flutter/material.dart';
import 'produtoheader.dart';
import 'produtoinfo.dart';
import 'produtobotaocomprar.dart';

//código desenvolvido pela Anna Beatriz Martins da Silva

void main() {
  runApp(const MikuStore());
}

class MikuStore extends StatelessWidget {
  const MikuStore({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'The Hatsune Miku Figure Store',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF00ece5),
        ),
      useMaterial3: true,
      ),
      home: const PaginaDetalhes(),
    );
  }
}

class PaginaDetalhes extends StatelessWidget{
  const PaginaDetalhes({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detalhes da figure',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xff00b3b0),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              ProdutoHeader(),
              SizedBox(height: 20,),
              ProdutoInfo(),
              SizedBox(height: 24,),
              ProdutoBotaoComprar(),
            ],
          ),
        ),
      ),
    );
  }
}