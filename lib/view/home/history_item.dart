import 'package:escanio_app/models/history.dart';
import 'package:escanio_app/models/products.dart';
import 'package:escanio_app/services/products.dart';
import 'package:escanio_app/utils/string.dart';
import 'package:escanio_app/view/home/product_item.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class HistoryItem extends StatelessWidget {
  History item;
  List<Product> products = [];
  HistoryItem({super.key, required this.item}) {
    timeago.setLocaleMessages("pt_BR", timeago.PtBrMessages());
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ProductsService.fromHistory(item.id).get(),
      builder: (context, snapshot) {
        var products = snapshot.data!.docs.map((p) => p.data());

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              StringUtils.toCamelCase(
                timeago.format(
                  item.date.toDate(),
                  locale: "pt_BR",
                ),
              ),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            ),
            ...products.map(
              (product) => ProductItem(
                item: product,
              ),
            ),
            const SizedBox(height: 24),
          ],
        );
      },
    );
  }
}
