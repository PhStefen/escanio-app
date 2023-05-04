import 'package:escanio_app/components/grid_view.dart';
import 'package:escanio_app/services/favorites.dart';
import 'package:escanio_app/utils/string.dart';
import 'package:flutter/material.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  void initState() {
    super.initState();
    print("fav page");
  }

  @override
  Widget build(BuildContext context) {
    return Text("fav");

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
                            // pesquisa = value;
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
          const Padding(padding: EdgeInsets.symmetric(vertical: 8)),
          Expanded(
            child: StreamBuilder(
              stream: FavoritesService.getAll(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Text('Carregando dados da coleção...');
                }
                if (snapshot.hasError) {
                  return const Text("Deu erro!");
                }

                var favorites = snapshot.data!.docs;

                return ListView(
                  children: [
                    ...favorites.map((doc) {
                      var name = StringUtils.toCamelCase(doc.data().name);

                      return SizedBox(
                        width: double.infinity,
                        child: Card(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: Wrap(
                              alignment: WrapAlignment.spaceBetween,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  direction: Axis.vertical,
                                  children: [
                                    Text(
                                      name,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () {
                                    FavoritesService.delete(doc.id);
                                  },
                                  child: const Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
