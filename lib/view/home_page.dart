import 'package:flutter/material.dart';
import 'package:widget_toolkit_qr/widget_toolkit_qr.dart';

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
        child: Column(
          children: [
            Card(
              elevation: 0,
              shape: const RoundedRectangleBorder(
                side: BorderSide(
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    const Padding(padding: EdgeInsets.only(left: 8)),
                    const Icon(Icons.search_rounded),
                    const Padding(padding: EdgeInsets.only(left: 8)),
                    const Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Pesquise o nome ou código do produtos"),
                      ),
                    ),
                    const Padding(padding: EdgeInsets.symmetric(horizontal: 8)),
                    IconButton(
                      icon: Icon(Icons.qr_code_rounded,
                          color: Colors.grey.shade600),
                      onPressed: () {},
                    ),
                    const Padding(padding: EdgeInsets.only(right: 8)),
                  ],
                ),
              ),
            ),
            Expanded(
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
            ),
          ],
        ),
      );
}

class QrService extends QrValidationService<String> {
  @override
  Future<String> validateQrCode(String qrCode) async {
    ///TODO: validate the qr data here
    return qrCode;
  }
}
