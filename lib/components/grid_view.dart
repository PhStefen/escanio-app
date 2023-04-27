import 'package:flutter/material.dart';

class MyGridView extends StatelessWidget {
  var lista = [];
  MyGridView({super.key, required this.lista});

  @override
  Widget build(BuildContext context) => Expanded(
        child: lista.isEmpty
            ? const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  "Lista vazia",
                  style: TextStyle(color: Colors.grey, fontSize: 32),
                ),
              )
            : GridView.count(
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                                // image: DecorationImage(
                                //   image: NetworkImage(
                                //     'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg',
                                //   ),
                                //   fit: BoxFit.cover,
                                // ),
                                color: Colors.grey,
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    myList['nome']
                                            .substring(0, 1)
                                            .toUpperCase() +
                                        myList['nome'].substring(1),
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    "R\$ ${myList['preco'].toString()}",
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
