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
        colorSchemeSeed: Colors.pink,
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
  final List<Livro> _livros = [];

  Future<void> _abrirCadastro() async {
    final novoLivro = await Navigator.push<Livro>(
      context,
      MaterialPageRoute(builder: (context) => const TelaCadastroLivro()),
    );

    if (novoLivro != null) {
      setState(() {
        _livros.add(novoLivro);
      });
    }
  }

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
          ? const Center(
              child: Text('Nenhum livro cadastrado. Toque em + para adicionar.'),
            )
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
        onPressed: _abrirCadastro,
        tooltip: 'Adicionar livro',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class TelaCadastroLivro extends StatefulWidget {
  const TelaCadastroLivro({super.key});

  @override
  State<TelaCadastroLivro> createState() => _TelaCadastroLivroState();
}

class _TelaCadastroLivroState extends State<TelaCadastroLivro> {
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _autorController = TextEditingController();

  static const List<String> _opcoesStatus = [
    'Quero ler',
    'Lendo',
    'Concluído',
  ];

  String _statusSelecionado = 'Quero ler';

  @override
  void dispose() {
    _tituloController.dispose();
    _autorController.dispose();
    super.dispose();
  }

  void _salvarLivro() {
    final titulo = _tituloController.text.trim();
    final autor = _autorController.text.trim();

    if (titulo.isEmpty || autor.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preencha o título e o autor do livro.')),
      );
      return;
    }

    final livro = Livro(
      titulo: titulo,
      autor: autor,
      status: _statusSelecionado,
    );

    Navigator.pop(context, livro);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar Livro'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _tituloController,
              decoration: const InputDecoration(
                labelText: 'Título',
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _autorController,
              decoration: const InputDecoration(
                labelText: 'Autor',
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.done,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _statusSelecionado,
              decoration: const InputDecoration(
                labelText: 'Status da leitura',
                border: OutlineInputBorder(),
              ),
              items: _opcoesStatus
                  .map(
                    (status) => DropdownMenuItem<String>(
                      value: status,
                      child: Text(status),
                    ),
                  )
                  .toList(),
              onChanged: (valor) {
                if (valor != null) {
                  setState(() {
                    _statusSelecionado = valor;
                  });
                }
              },
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: _salvarLivro,
              icon: const Icon(Icons.save),
              label: const Text('Salvar Livro'),
            ),
          ],
        ),
      ),
    );
  }
}