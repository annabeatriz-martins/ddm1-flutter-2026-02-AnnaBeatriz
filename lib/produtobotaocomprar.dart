import 'package:flutter/material.dart';

class ProdutoBotaoComprar extends StatelessWidget{
  const ProdutoBotaoComprar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xff00b3b0),
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: (){
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Hatsune Miku Figure adicionada ao carrinho!'),
                backgroundColor: Color(0xff00838f),
                duration: Duration(seconds: 3),
              ),
            );
          },
          icon: const Icon(Icons.shopping_cart, color: Colors.white),
          label: const Text(
            'Adicionar ao carrinho',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}