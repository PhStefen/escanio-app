import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:escanio_app/components/grid_view.dart';
import 'package:escanio_app/services/history.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String pesquisa = '';

  @override
  void initState() {
    super.initState();

    HistoryService.add("10", 15);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //Barra Pesquisa
        Padding(
          padding: const EdgeInsets.only(top: 8, left: 16, right: 16),
          child: Card(
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
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Pesquise o nome ou código do produtos",
                      ),
                      onChanged: (value) {
                        setState(() {
                          pesquisa = value;
                        });
                      },
                    ),
                  ),
                  const Padding(padding: EdgeInsets.symmetric(horizontal: 8)),
                  IconButton(
                    icon: Icon(Icons.qr_code_rounded,
                        color: Colors.grey.shade600),
                    onPressed: () {
                      Navigator.of(context).pushNamed("/scanner");
                    },
                  ),
                  const Padding(padding: EdgeInsets.only(right: 8)),
                ],
              ),
            ),
          ),
        ),
        //Items
        StreamBuilder(
          stream: firestore.collection('produtos').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const CircularProgressIndicator();
            }

            var products = snapshot.data!.docs;

            if (pesquisa.isEmpty) {
              return MyGridView(lista: products);
            }

            var productsSearch = [];
            for (int i = 0; i < products.length; i++) {
              //for (i in products) também funciona
              if (products[i]
                  .data()['nome']
                  .toLowerCase()
                  .contains(pesquisa.toLowerCase())) {
                productsSearch.add(products[i]);
              }
            }

            return MyGridView(lista: productsSearch);
          },
        ),
      ],
    );
  }
}
