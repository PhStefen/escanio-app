import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyCard extends StatelessWidget {

  final BuildContext context;

  MyCard({super.key, required this.context});


  @override
  Widget build(BuildContext context) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => Navigator.of(context).pop(),
        child: DraggableScrollableSheet(
          initialChildSize: 0.4,
          minChildSize: .4,
          maxChildSize: .7,
          builder: (context, scrollController) => Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              color: Colors.white,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                const SizedBox(height: 5),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(),
                    const Text(
                      "Produto",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: 30,
                    itemBuilder: (context, index) {
                      return ListTile(
                          title: Text("Preço $index"),
                          subtitle: Text("$index/$index/$index"),
                          // leading: Icon(Icons.arrow_circle_down_outlined),
                          trailing: index % 3 == 0
                              ? const Icon(Icons.remove_circle_outline_rounded)
                              : index % 2 == 0
                                  ? const Icon(
                                      Icons.arrow_circle_down_rounded,
                                      color: Colors.green,
                                    )
                                  : const Icon(
                                      Icons.arrow_circle_up_rounded,
                                      color: Colors.red,
                                    ));
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
