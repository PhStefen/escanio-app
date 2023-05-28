import 'package:escanio_app/components/prices_modal.dart';
import 'package:escanio_app/models/history.dart';
import 'package:escanio_app/services/history_service.dart';
import 'package:escanio_app/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProductCard extends StatelessWidget {
  final History history;
  const ProductCard({super.key, required this.history});

  void onTap() {
    history.isFavourite = !history.isFavourite;
    HistoryService.collection.doc(history.id).set(history);
  }

  @override
  Widget build(BuildContext context) {
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
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16), topRight: Radius.circular(16)),
            ),
            builder: (context) =>
                PricesModal(context: context, productId: history.id),
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
                      history.name.toCamelCase(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      NumberFormat.currency(
                        locale: 'pt_BR',
                        decimalDigits: 2,
                        symbol: 'R\$',
                      ).format(history.price),
                    )
                  ],
                ),
                GestureDetector(
                  onTap: onTap,
                  child: history.isFavourite
                      ? const Icon(
                          Icons.favorite,
                          color: Colors.red,
                        )
                      : const Icon(
                          Icons.favorite_border,
                          color: Colors.red,
                        ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
