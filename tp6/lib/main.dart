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

  Future<void> _pesquisaReceita(String query) async {
    if (query.trim().isEmpty) return;

    try {
      final url = Uri.parse(
          'https://www.themealdb.com/api/json/v1/1/search.php?s=${Uri.encodeComponent(query)}');
      
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _receitas = data['meals'] ?? [];
        });
      }
    } catch (e) {
      debugPrint('Erro ao buscar receitas: $e');
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
              child: ListView.builder(
                itemCount: _receitas.length,
                itemBuilder: (context, index) {
                  final recipe = _receitas[index];
                  return ListTile(
                    leading: Image.network(
                      recipe['strMealThumb'] ?? '',
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    title: Text(recipe['strMeal'] ?? ''),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}