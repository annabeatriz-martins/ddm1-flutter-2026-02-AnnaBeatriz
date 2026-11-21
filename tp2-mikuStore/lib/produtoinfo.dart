import 'package:flutter/material.dart';

class ProdutoInfo extends StatelessWidget{
  const ProdutoInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Fabricante',
                style: TextStyle(
                  fontWeight: FontWeight.bold, 
                  fontSize: 15),
                ),
                Text(
                  'Good Smile Company',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black87),
                ),
              ],
            ),
            const Divider(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Altura:',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
                ),
                Text(
                  'Aproximadamente 24 cm',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black87),
                ),
              ],
            ),
            const Divider(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Material:',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
                ),
                Text(
                  'PVC & ABS',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black87),
                ),
              ],
            ),
            const Divider(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Preço:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Color(0xff00b3b0),
                  ),
                ),
                Text(
                  'R\$ 899,90',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}