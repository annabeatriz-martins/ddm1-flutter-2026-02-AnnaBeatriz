import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

//Anna Beatriz Martins da Silva

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
   return MaterialApp(
    title: "Busca de receitas",
    theme: ThemeData(
      primarySwatch: Colors.pink,
      useMaterial3: true,
    ),
    home: const ReceitaPagPesquisa(),
    debugShowCheckedModeBanner: false,
   );
  }
}

class ReceitaPagPesquisa extends StatefulWidget{
  const ReceitaPagPesquisa({super.key});

  @override
  State<ReceitaPagPesquisa> createState() => _ReceitaPagPesquisaEstado();
}

class _ReceitaPagPesquisaEstado extends State<ReceitaPagPesquisa>{
  final TextEditingController _controller = TextEditingController();
  List<dynamic> _receitas = [];

  bool _estaCarregando = false;
  bool _foiPesquisado = false;
  String? _errorMessage;

  Future<void> _pesquisaReceita(String query) async {
    if (query.trim().isEmpty) return;

    setState(() {
      _estaCarregando = true;
      _foiPesquisado = true;
      _errorMessage = null;
      _receitas = [];
    });

    try {
      final url = Uri.parse(
          'https://www.themealdb.com/api/json/v1/1/search.php?s=${Uri.encodeComponent(query)}');
      
      final response = await http.get(url).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _receitas = data['meals'] ?? [];
        });
      }else {
      setState(() {
        _errorMessage = 'Erro no servidor. Código: ${response.statusCode}';
        _estaCarregando = false;
      });
    }
  } catch (e) {
    setState(() {
      _errorMessage = 'Falha na conexão. Verifique sua internet e tente novamente.';
      _estaCarregando = false;
    });
    debugPrint('Erro detalhado: $e');
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Receitas - Anna Beatriz"),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      labelText: "Digite o nome da receita",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.search),
                    ),
                    onSubmitted: (value) => _pesquisaReceita(value),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () => _pesquisaReceita(_controller.text),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      vertical: 16, horizontal: 20
                    ),
                  ),
                  child: const Text("Buscar"),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: _body(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _body() {
    if (_estaCarregando) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_errorMessage != null) {
      return Center(
        child: Text(
          _errorMessage!,
          style: const TextStyle(color: Colors.red, fontSize: 16),
          textAlign: TextAlign.center,
        ),
      );
    }

    if (_foiPesquisado && _receitas.isEmpty) {
      return const Center(
        child: Text(
          'Nenhuma receita encontrada para esta pesquisa.',
          style: TextStyle(fontSize: 16, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
      );
    }

    if (!_foiPesquisado) {
      return const Center(
        child: Text(
          'Digite um termo acima e clique em "Buscar" para encontrar receitas.',
          style: TextStyle(fontSize: 16, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
      );
    }

    return ListView.builder(
      itemCount: _receitas.length,
      itemBuilder: (context, index) {
        final recipe = _receitas[index];
        return Card(
          elevation: 3,
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                recipe['strMealThumb'] ?? '',
                width: 60,
                height: 60,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.broken_image, size: 60),
              ),
            ),
            title: Text(
              recipe['strMeal'] ?? 'Nome indisponível',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              'Categoria: ${recipe['strCategory'] ?? 'N/A'} | País: ${recipe['strArea'] ?? 'N/A'}',
            ),
          ),
        );
      },
    );
  }
}