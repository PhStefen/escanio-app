import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:escanio_app/components/grid_view.dart';
import 'package:flutter/material.dart';
import 'package:widget_toolkit_qr/widget_toolkit_qr.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //Barra Pesquisa
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
                  icon:
                      Icon(Icons.qr_code_rounded, color: Colors.grey.shade600),
                  onPressed: () {},
                ),
                const Padding(padding: EdgeInsets.only(right: 8)),
              ],
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

            return MyGridView(lista: products);
          },
        ),
      ],
    );
  }
}

class QrService extends QrValidationService<String> {
  @override
  Future<String> validateQrCode(String qrCode) async {
    ///TODO: validate the qr data here
    return qrCode;
  }
}
