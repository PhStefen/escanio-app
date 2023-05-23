import 'package:escanio_app/extensions/iterable_extension.dart';
import 'package:escanio_app/services/products_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PricesModal extends StatelessWidget {
  final BuildContext context;
  final String productId;

  const PricesModal(
      {super.key, required this.context, required this.productId});

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
                  child: FutureBuilder(
                    future: ProductsService.collection.doc(productId).get(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const CircularProgressIndicator();
                      }

                      var product = snapshot.data!.data()!;

                      return Column(
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
                                product.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: product.prices.isNotEmpty
                                ? ListView.separated(
                                    separatorBuilder: (context, index) =>
                                        const Divider(),
                                    itemCount: product.prices.length,
                                    itemBuilder: (context, index) {
                                      var currentPrice = product.prices[index];
                                      var nextPrice = product.prices
                                          .elementAtOrNull(index + 1);

                                      Icon? icon;
                                      if (nextPrice != null &&
                                          currentPrice.value !=
                                              nextPrice.value) {
                                        icon = currentPrice.value >
                                                nextPrice.value
                                            ? const Icon(
                                                Icons.arrow_circle_up_rounded,
                                                color: Colors.red,
                                              )
                                            : const Icon(
                                                Icons.arrow_circle_down_rounded,
                                                color: Colors.green,
                                              );
                                      }

                                      return ListTile(
                                        title: Text(
                                          NumberFormat.currency(
                                            locale: 'pt_BR',
                                            decimalDigits: 2,
                                            symbol: 'R\$',
                                          ).format(currentPrice.value),
                                        ),
                                        subtitle: Text(DateFormat("dd/MM/yyyy")
                                            .format(
                                                currentPrice.date.toDate())),
                                        trailing: icon,
                                      );
                                    },
                                  )
                                : const Text("Sem preço"),
                          ),
                        ],
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      );
}
