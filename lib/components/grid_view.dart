import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';

class MyGridView extends StatelessWidget {
  var lista = [];
  MyGridView({super.key, required this.lista});

  @override
  Widget build(BuildContext context) => Expanded(
          child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: lista.isEmpty
            ? const Text(
                "Lista vazia",
                style: TextStyle(color: Colors.grey, fontSize: 32),
              )
            : MasonryGridView.count(
                crossAxisCount: 1,
                itemCount: lista.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  lista[index]['nome']
                                      .toString()
                                      .replaceFirstMapped(
                                        RegExp(r'.'),
                                        (match) => match.group(0)!.toUpperCase(),
                                      ),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                const Text(
                                  "10/10/2023",
                                  style: TextStyle(fontSize: 12),
                                )
                              ],
                            ),
                            const Padding(padding: EdgeInsets.symmetric(vertical: 4)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  NumberFormat.currency(
                                    locale: 'pt_BR',
                                    decimalDigits: 2,
                                    symbol: 'R\$',
                                  ).format(lista[index]['preco']),
                                ),
                                const Icon(
                                  Icons.arrow_circle_up_rounded,
                                  color: Colors.red,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
      ));
}
