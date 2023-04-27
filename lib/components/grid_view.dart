import 'package:escanio_app/components/my_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

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
                    child: MyCard(produto: lista[index]),
                  );
                },
              ),
      ));
}
