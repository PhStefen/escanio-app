import 'package:escanio_app/components/product_card.dart';
import 'package:escanio_app/services/favorites_service.dart';
import 'package:escanio_app/services/history_service.dart';
import 'package:escanio_app/utils/string_utils.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> with AutomaticKeepAliveClientMixin<FavoritesPage> {
  @override
  bool get wantKeepAlive => true;

  String pesquisa = '';

  @override
  void initState() {
    super.initState();
    timeago.setLocaleMessages("pt_BR", timeago.PtBrMessages());
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
                    IconButton(
                      icon: Icon(Icons.qr_code_rounded, color: Colors.grey.shade600),
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
          const SizedBox(height: 26),
          Expanded(
            child: FirestoreListView(
              query: FavoritesService.getAll(),
              emptyBuilder: (_) => const Center(
                child: Text("Nenhum produto foi escâneado ainda"),
              ),
              errorBuilder: (context, error, stackTrace) => Text(error.toString()),
              itemBuilder: (_, snapshot) {
                return ProductCard(productId: snapshot.id);
              },
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
