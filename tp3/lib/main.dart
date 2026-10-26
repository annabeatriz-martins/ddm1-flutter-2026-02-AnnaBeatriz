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
        primarySwatch: Colors.red,
      ),
      home: const TuristicoHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class PontoTuristico {
  final String nome;
  final String cidade;
  final String imagemUrl;
  final String descricao;
  bool favorito;
  bool visitado;

  PontoTuristico({
    required this.nome,
    required this.cidade,
    required this.imagemUrl,
    required this.descricao,
    this.favorito = false,
    this.visitado = false,
  });
}

class TuristicoHomePage extends StatefulWidget {
  const TuristicoHomePage({super.key});

  @override
  State<TuristicoHomePage> createState() => _TuristicoHomePageState();
}

class _TuristicoHomePageState extends State<TuristicoHomePage> {
  final List<PontoTuristico> _pontosTuristicos = [
    PontoTuristico(
      nome: 'Monte Serrat',
      cidade: 'Santos',
      imagemUrl: 'https://images.unsplash.com/photo-1544644181-1484b3fdfc62?q=80&w=600',
      descricao: 'Oferece uma vista panorâmica de 360 graus da cidade de Santos, acessível por bondinho.',
    ),
    PontoTuristico(
      nome: 'Aquário de Santos',
      cidade: 'Santos',
      imagemUrl: 'https://images.unsplash.com/photo-1522069169874-c58ec4b76be5?q=80&w=600',
      descricao: 'O aquário público mais antigo do país, localizado na Ponta da Praia.',
    ),
    PontoTuristico(
      nome: 'Teleférico de São Vicente',
      cidade: 'São Vicente',
      imagemUrl: 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?q=80&w=600',
      descricao: 'Primeiro teleférico instalado no Brasil sobre o mar, na Praia do Itararé.',
    ),
    PontoTuristico(
      nome: 'Ilha Porchat',
      cidade: 'São Vicente',
      imagemUrl: 'https://images.unsplash.com/photo-1519046904884-53103b34b206?q=80&w=600',
      descricao: 'Conhecida por sua vista privilegiada do litoral e monumentos históricos.',
    ),
    PontoTuristico(
      nome: 'Mirante da Campina',
      cidade: 'Guarujá',
      imagemUrl: 'https://images.unsplash.com/photo-1506744038136-46273834b3fb?q=80&w=600',
      descricao: 'Também conhecido como Morro do Maluf, excelente para contemplar a Praia das Pitangueiras.',
    ),
    PontoTuristico(
      nome: 'Praia de Pernambuco',
      cidade: 'Guarujá',
      imagemUrl: 'https://images.unsplash.com/photo-1519046904884-53103b34b206?q=80&w=600',
      descricao: 'Praia paradisíaca com faixa de areia que se conecta à Ilha dos Arvoredos na maré baixa.',
    ),
    PontoTuristico(
      nome: 'Forte de São João',
      cidade: 'Bertioga',
      imagemUrl: 'https://images.unsplash.com/photo-1488646953014-85cb44e25828?q=80&w=600',
      descricao: 'A fortaleza militar mais antiga do Brasil, construída no século XVI.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Turismo na Baixada Santista'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: _pontosTuristicos.length,
        itemBuilder: (context, index) {
          final ponto = _pontosTuristicos[index];
          return _buildCardPontoTuristico(ponto);
        },
      ),
    );
  }

  Widget _buildCardPontoTuristico(PontoTuristico ponto) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              ponto.imagemUrl,
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                height: 180,
                color: Colors.grey[300],
                child: const Center(child: Icon(Icons.image_not_supported, size: 50)),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            ponto.nome,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.location_on, size: 16, color: Colors.red),
              const SizedBox(width: 4),
              Text(
                'Cidade: ${ponto.cidade}',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[700],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            ponto.descricao,
            style: const TextStyle(fontSize: 14, color: Colors.black87),
          ),
          const Divider(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  Checkbox(
                    value: ponto.favorito,
                    onChanged: (bool? value) {
                      setState(() {
                        ponto.favorito = value ?? false;
                      });
                    },
                  ),
                  const Text('Favorito'),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                    value: ponto.visitado,
                    onChanged: (bool? value) {
                      setState(() {
                        ponto.visitado = value ?? false;
                      });
                    },
                  ),
                  const Text('Visitado'),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}