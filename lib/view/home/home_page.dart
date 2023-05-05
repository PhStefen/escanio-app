import 'package:escanio_app/services/history.dart';
import 'package:escanio_app/view/home/history_list.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
            child: FutureBuilder(
              future: HistoryService.getAll(),
              builder: (context, snapshot) {
                return Text('Teste');
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Text('Carregando dados da coleção...');
                }
                if (snapshot.hasError) {
                  return const Text("Deu erro!");
                }

                var groups = snapshot.data!.docs.map((e) => e.data()).toList();
                return HistoryList(list: groups);
              },
            ),
          ),
        ],
      ),
    );
  }
}
