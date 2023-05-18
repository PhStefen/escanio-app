import 'package:escanio_app/models/price.dart';

class Product {
  Product({
    required this.id,
    required this.name,
    required this.prices,
    required this.isFavourite,
  });

  Product.fromJson(Map<String, Object?> json)
      : this(
          id: json['id'] as String,
          name: json['name']! as String,
          prices: (json['prices']! as List<Map<String, Object?>>)
              .map((json) => Price.fromJson(json))
              .toList(),
          isFavourite: json['isFavourite']! as bool,
        );

  final String id;
  final bool isFavourite;
  final String name;
  final List<Price> prices;
  Map<String, Object?> toJson() {
    return {
      'name': name,
      'isFavourite': isFavourite,
      'prices': prices.map((e) => e.toJson()),
    };
  }
}
