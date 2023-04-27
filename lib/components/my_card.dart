import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyCard extends StatelessWidget {
  QueryDocumentSnapshot<Map<String, dynamic>> produto;
  MyCard({super.key, required this.produto});

  @override
  Widget build(BuildContext context) => Card(
        // elevation: 0,
        // shape: const RoundedRectangleBorder(
        //   side: BorderSide(
        //     color: Colors.grey,
        //   ),
        //   borderRadius: BorderRadius.all(Radius.circular(12)),
        // ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    produto['nome'].toString().replaceFirstMapped(
                          RegExp(r'.'),
                          (match) => match.group(0)!.toUpperCase(),
                        ),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    "10/10/2023",
                    style: TextStyle(fontSize: 12),
                  )
                ],
              ),
              const Padding(padding: EdgeInsets.symmetric(vertical: 4)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    NumberFormat.currency(
                      locale: 'pt_BR',
                      decimalDigits: 2,
                      symbol: 'R\$',
                    ).format(produto['preco']),
                  ),
                  IconButton(
                    // Icons.arrow_circle_up_rounded,
                    icon: Icon(produto['favorito']
                        ? Icons.favorite
                        : Icons.favorite_border),
                    color: Colors.red,
                    onPressed: () {
                      produto.reference.update({
                        'favorito': !produto['favorito'],
                      });
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      );
}
