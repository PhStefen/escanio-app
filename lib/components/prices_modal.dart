import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:escanio_app/models/price.dart';
import 'package:escanio_app/models/products.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PricesModal extends StatelessWidget {
  final BuildContext context;
  final DocumentReference<Product> reference;
  final String name;
  final pricesList = <Price>[];

  PricesModal(
      {super.key,
      required this.context,
      required this.name,
      required this.reference});

  @override
  Widget build(BuildContext context) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => Navigator.of(context).pop(),
        child: DraggableScrollableSheet(
          initialChildSize: 0.4,
          minChildSize: .4,
          maxChildSize: .7,
          builder: (context, scrollController) => Container(
            decoration: BoxDecoration(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(16)),
              color: Theme.of(context).cardColor,
            ),
            child: Stack(
              children: [
                Positioned(
                  right: 0,
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: Column(
                    children: [
                      const SizedBox(height: 5),
                      Center(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 4),
                          child: Text(
                            name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: FutureBuilder(
                          future: reference
                              .collection("prices")
                              .orderBy("date", descending: true)
                              .withConverter<Price>(
                                fromFirestore: (snapshot, _) =>
                                    Price.fromJson(snapshot.data()!),
                                toFirestore: (model, _) => model.toJson(),
                              )
                              .get(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return const CircularProgressIndicator();
                            }

                            if (snapshot.data!.docs.isEmpty) {
                              return const Center(
                                child: Text("Sem preço",
                                    style: TextStyle(color: Colors.grey)),
                              );
                            }

                            var prices = snapshot.data!.docs
                                .map((e) => e.data())
                                .toList();
                            return ListView.separated(
                              separatorBuilder: (context, index) =>
                                  const Divider(),
                              itemCount: prices.length,
                              itemBuilder: (context, index) {
                                var price = prices[index];

                                Icon? icon;
                                if (index != prices.length - 1) {
                                  var previousValue = prices[index + 1].value;
                                  var currentValue = price.value;
                                  if (currentValue != previousValue) {
                                    icon = currentValue > previousValue
                                        ? const Icon(
                                            Icons.arrow_circle_up_rounded,
                                            color: Colors.red,
                                          )
                                        : const Icon(
                                            Icons.arrow_circle_down_rounded,
                                            color: Colors.green,
                                          );
                                  }
                                }

                                return ListTile(
                                  title: Text(
                                    NumberFormat.currency(
                                      locale: 'pt_BR',
                                      decimalDigits: 2,
                                      symbol: 'R\$',
                                    ).format(price.value),
                                  ),
                                  subtitle: Text(DateFormat("dd/MM/yyyy")
                                      .format(price.date.toDate())),
                                  trailing: icon,
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
}
