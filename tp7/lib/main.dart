import 'package:flutter/material.dart';

void main() {
  runApp(const MinhaEstanteApp());
}

//Anna Beatriz Martins da Silva

class Livro {
  final String titulo;
  final String autor;
  final String status;

  Livro({
    required this.titulo,
    required this.autor,
    required this.status,
  });
}

class MinhaEstanteApp extends StatelessWidget {
  const MinhaEstanteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de Livros',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.deepPurple,
        useMaterial3: true,
      ),
      home: const TelaInicial(),
    );
  }
}

class TelaInicial extends StatefulWidget {
  const TelaInicial({super.key});

  @override
  State<TelaInicial> createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  final List<Livro> _livros = [
    Livro(
      titulo: 'O Verão que Hikaru Morreu',
      autor: 'Mokumokuren',
      status: 'Lendo',
    ),
    Livro(
      titulo: 'Diários de uma apotecária',
      autor: 'Natsu Hyuuga',
      status: 'Quero ler',
    ),
    Livro(
      titulo: 'Demon Slayer - Kimetsu no Yaiba',
      autor: 'Koyoharu  Gotouge',
      status: 'Concluído',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Meus Livros - Anna Beatriz',
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
      body: _livros.isEmpty
          ? const Center(child: Text('Nenhum livro cadastrado ainda.'))
          : ListView.builder(
              itemCount: _livros.length,
              itemBuilder: (context, index) {
                final livro = _livros[index];
                return ListTile(
                  leading: const Icon(Icons.book),
                  title: Text(livro.titulo),
                  subtitle: Text('${livro.autor} • ${livro.status}'),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
        },
        tooltip: 'Adicionar livro',
        child: const Icon(Icons.add),
      ),
    );
  }
}