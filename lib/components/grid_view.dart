import 'package:flutter/material.dart';

class MyGridView extends StatelessWidget {
  var lista = [];
  MyGridView({super.key, required this.lista});

  @override
  Widget build(BuildContext context) => Expanded(
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 20, // Espaço entre as linhas
          crossAxisSpacing: 20,
          children: lista
              .map(
                (myList) => Card(
                  child: Stack(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                              'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        child: Column(
                          children: [
                            Text(
                              myList['nome'],
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              myList['preco'].toString(),
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ), //Forma de dar espaçamento vertical
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
        ),
      );
}
