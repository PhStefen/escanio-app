import 'package:escanio_app/components/grid_view.dart';
import 'package:flutter/material.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
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
                  onPressed: () {
                    Navigator.of(context).pushNamed("/scanner");
                  },
                ),
                const Padding(padding: EdgeInsets.only(right: 8)),
              ],
            ),
          ),
        ),
        MyGridView(lista: [])
      ],
    );
    ;
  }
}
