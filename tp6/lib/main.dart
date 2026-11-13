import 'package:flutter/material.dart';

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
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: (){

                  },
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
            const Expanded(
              child: Center(
                child: Text(
                  "Digite um termo acima e clique em 'Buscar'.",
                  style: TextStyle(fontSize: 16,color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}