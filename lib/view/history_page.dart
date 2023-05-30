import 'package:escanio_app/components/product_card.dart';
import 'package:escanio_app/models/history.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:escanio_app/extensions/iterable_extension.dart';
import 'package:escanio_app/extensions/string_extension.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key, required this.history});
  final List<History> history;

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
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
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed("/scanner");
                        },
                        child: const TextField(
                          enabled: false,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Pesquise o nome ou código do produtos",
                          ),
                        ),
                      ),
                    ),
                    const Padding(padding: EdgeInsets.symmetric(horizontal: 8)),
                    const Icon(Icons.qr_code_rounded),
                    const Padding(padding: EdgeInsets.only(right: 8)),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.history.length,
              itemBuilder: (context, index) {
                var currentHistory = widget.history[index];
                var nextHistory = widget.history.elementAtOrNull(index + 1);
                var children = <Widget>[ProductCard(history: currentHistory)];
                var isFirstItem = index == 0;

                if (isFirstItem ||
                    (nextHistory != null &&
                        !DateUtils.isSameDay(currentHistory.lastSeen.toDate(),
                            currentHistory.lastSeen.toDate()))) {
                  children = [
                    const SizedBox(height: 12),
                    Text(
                      timeago
                          .format(
                            currentHistory.lastSeen.toDate(),
                            locale: "pt_BR",
                          )
                          .toCamelCase(),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                    ...children
                  ];
                }

                return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: children);
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
