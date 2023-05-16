import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:escanio_app/components/prices_modal.dart';
import 'package:escanio_app/models/price.dart';
import 'package:escanio_app/models/products.dart';
import 'package:escanio_app/services/favorites_service.dart';
import 'package:escanio_app/services/products_service.dart';
import 'package:escanio_app/utils/string_utils.dart';
import 'package:escanio_app/view/home_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProductCard extends StatelessWidget {
  final String productId;

  DocumentReference<Product>? productReference;
  ProductCard({super.key, required this.productId}) {
    productReference = ProductsService.collection.doc(productId);
  }

  Future onTap(bool alreadyExists) async {
    await (alreadyExists ? FavoritesService.delete(productId) : FavoritesService.post(productId));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: productReference!.get(),
      builder: (_, snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicatorCard();
        }

        var product = snapshot.data!.data();

        return SizedBox(
          width: double.infinity,
          child: Card(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            child: InkWell(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              onTap: () => showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                backgroundColor: Colors.transparent,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
                ),
                builder: (context) => PricesModal(context: context, name: product.name, reference: productReference!),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                child: Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Wrap(
                      spacing: 4,
                      runSpacing: 4,
                      direction: Axis.vertical,
                      children: [
                        Text(
                          StringUtils.toCamelCase(product!.name),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        StreamBuilder(
                          stream: productReference!
                              .collection("prices")
                              .orderBy("date", descending: true)
                              .limit(1)
                              .withConverter<Price>(
                                fromFirestore: (snapshot, _) => Price.fromJson(snapshot.data()!),
                                toFirestore: (model, _) => model.toJson(),
                              )
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            }

                            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                              return const Text(
                                "Sem preço",
                                style: TextStyle(color: Colors.grey),
                              );
                            }

                            var price = snapshot.data!.docs[0].data();
                            return Text(
                              NumberFormat.currency(
                                locale: 'pt_BR',
                                decimalDigits: 2,
                                symbol: 'R\$',
                              ).format(price.value),
                            );
                          },
                        ),
                      ],
                    ),
                    StreamBuilder(
                        stream: FavoritesService.collection.doc(productId).snapshots(),
                        builder: (context, snapshot) {
                          var alreadyExists = snapshot.data != null ? snapshot.data!.exists : false;
                          return GestureDetector(
                            onTap: () => onTap(alreadyExists),
                            child: alreadyExists
                                ? const Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                  )
                                : const Icon(
                                    Icons.favorite_border,
                                    color: Colors.red,
                                  ),
                          );
                        }),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
