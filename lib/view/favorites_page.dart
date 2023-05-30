import 'package:escanio_app/components/product_card.dart';
import 'package:escanio_app/models/history.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class FavoritesPage extends StatefulWidget {
  final List<History> favourites;
  const FavoritesPage({super.key, required this.favourites});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  String pesquisa = '';

  @override
  void initState() {
    super.initState();
    timeago.setLocaleMessages("pt_BR", timeago.PtBrMessages());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          //Barra Pesquisa
          Padding(
            padding: const EdgeInsets.only(top: 8),
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
                    // const Padding(padding: EdgeInsets.only(right: 8)),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 26),
          Expanded(
            child: ListView(
              children: widget.favourites.map(
                (e) {
                  if (pesquisa.isEmpty) return ProductCard(history: e);
                  if (e.name.toLowerCase().contains(pesquisa.toLowerCase())) {
                    // print("pesquisa: $pesquisa, nome: ${e.name}");
                    return ProductCard(history: e);
                  }
                  return const SizedBox.shrink();
                },
              ).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class CircularProgressIndicatorCard extends StatelessWidget {
  const CircularProgressIndicatorCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        width: double.infinity,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ),
      ),
    );
  }
}
