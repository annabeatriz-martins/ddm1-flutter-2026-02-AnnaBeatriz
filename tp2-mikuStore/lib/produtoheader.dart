import 'package:flutter/material.dart';

class ProdutoHeader extends StatelessWidget {
  const ProdutoHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xffe0f7f6),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xff00b3b0),width: 2)
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.star,
                size: 80,
                color: Color(0xff00b3b0),
              ),
              SizedBox(height: 14),
              Text(
                '♪ VOCALOID Collector Series ♪',
                style: TextStyle(
                  color: Color(0xff00838f),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Hatsune Miku - Versão Escala 1/7',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xff006064),
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'Action Figure / Colecionável Oficial',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }
}