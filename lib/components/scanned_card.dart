import 'package:escanio_app/components/prices_modal.dart';
import 'package:escanio_app/extensions/string_extension.dart';
import 'package:escanio_app/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ScannedCard extends StatelessWidget {
  final ProductModel product;
  const ScannedCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        child: InkWell(
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          onTap: () => showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            backgroundColor: Colors.transparent,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16), topRight: Radius.circular(16)),
            ),
            builder: (context) =>
                PricesModal(context: context, productId: product.id),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
                      product.name.toCamelCase(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      NumberFormat.currency(
                        locale: 'pt_BR',
                        decimalDigits: 2,
                        symbol: 'R\$',
                      ).format(product.prices.first.value),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
