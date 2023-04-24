import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        MyGridView(),
      ],
    );
  }
}

class MyGridView extends StatelessWidget {
  const MyGridView({super.key});

  @override
  Widget build(BuildContext context) => Expanded(
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 20, // Espaço entre as linhas
          crossAxisSpacing: 20,
          children: [
            Card(
              child: Stack(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Column(
                    children: const [
                      SizedBox(
                        height: 16,
                      ), //Substituindo o padding criando isso.
                      Text(
                        'Título do Card',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Descrição do Card',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            Card(
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
                      children: const [
                        Text(
                          'Título do Card',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Descrição do Card',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ), //Forma de dar espaçamento vertical
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
