import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

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

  Map<String, dynamic> toMap() {
    return {
      'titulo': titulo,
      'autor': autor,
      'status': status,
    };
  }

  factory Livro.fromMap(Map<String, dynamic> map) {
    return Livro(
      titulo: map['titulo'] as String,
      autor: map['autor'] as String,
      status: map['status'] as String,
    );
  }
}

class MinhaEstanteApp extends StatelessWidget {
  const MinhaEstanteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de Livros - Anna Beatriz ',
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
  static const String _chaveLivros = 'livros_cadastrados';
  final List<Livro> _livros = [];
  bool _carregando = true;

  @override
  void initState() {
    super.initState();
    _carregarLivros();
  }

  Future<void> _carregarLivros() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_chaveLivros);

    if (jsonString != null && jsonString.isNotEmpty) {
      final List<dynamic> listaDecodificada = jsonDecode(jsonString);
      final livrosSalvos = listaDecodificada
          .map((item) => Livro.fromMap(Map<String, dynamic>.from(item)))
          .toList();

      setState(() {
        _livros
          ..clear()
          ..addAll(livrosSalvos);
        _carregando = false;
      });
    } else {
      setState(() {
        _carregando = false;
      });
    }
  }

  Future<void> _salvarLivrosNoDisco() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(_livros.map((livro) => livro.toMap()).toList());
    await prefs.setString(_chaveLivros, jsonString);
  }

  void _mostrarMensagem(String mensagem) {
    if (!mounted) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text(mensagem)),
      );
  }

  Future<void> _abrirCadastro() async {
    final novoLivro = await Navigator.push<Livro>(
      context,
      MaterialPageRoute(builder: (context) => const TelaCadastroLivro()),
    );

    if (novoLivro != null) {
      setState(() {
        _livros.add(novoLivro);
      });
      await _salvarLivrosNoDisco();
      _mostrarMensagem('"${novoLivro.titulo}" adicionado à lista.');
    }
  }

  Future<void> _removerLivro(int index) async {
    final livroRemovido = _livros[index];
    setState(() {
      _livros.removeAt(index);
    });
    await _salvarLivrosNoDisco();
    _mostrarMensagem('"${livroRemovido.titulo}" removido da lista.');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Meus Livros',
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
      body: _carregando
          ? const Center(child: CircularProgressIndicator())
          : _livros.isEmpty
              ? const Center(
                  child: Text(
                    'Nenhum livro cadastrado.\nToque em + para adicionar o primeiro.',
                    textAlign: TextAlign.center,
                  ),
                )
              : ListView.builder(
                  itemCount: _livros.length,
                  itemBuilder: (context, index) {
                    final livro = _livros[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      child: ListTile(
                        leading: const Icon(Icons.book),
                        title: Text(livro.titulo),
                        subtitle: Text('${livro.autor} • ${livro.status}'),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete_outline),
                          tooltip: 'Remover livro',
                          onPressed: () => _removerLivro(index),
                        ),
                      ),
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
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
            content: Text('Por favor, informe o título e o autor.'),
          ),
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
              onSubmitted: (_) => _salvarLivro(),
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