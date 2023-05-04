import 'package:escanio_app/models/products.dart';
import 'package:escanio_app/services/favorites.dart';
import 'package:escanio_app/services/products.dart';
import 'package:escanio_app/utils/string.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProductItem extends StatelessWidget {
  Product item;
  ProductItem({super.key, required this.item});

  Future onTap() async {
    FavoritesService.add(item.id, item.name);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Wrap(
                spacing: 8,
                runSpacing: 8,
                direction: Axis.vertical,
                children: [
                  Text(
                    StringUtils.toCamelCase(item.name),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    NumberFormat.currency(
                      locale: 'pt_BR',
                      decimalDigits: 2,
                      symbol: 'R\$',
                    ).format(item.price),
                  ),
                ],
              ),
              GestureDetector(
                onTap: onTap,
                child: Icon(
                  Icons.favorite_border,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
