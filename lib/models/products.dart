import 'package:escanio_app/models/price.dart';

class Product {
  Product({
    required this.id,
    required this.name,
    required this.prices,
    required this.barCode,
  });

  Product.fromJson(Map<String, Object> json)
      : this(
            id: json['id'] as String,
            name: json['name'] as String? ?? '',
            prices: (json['prices'] as List<dynamic>? ?? [])
                .map((json) => Price.fromJson(json))
                .toList(),
            barCode: json['barCode'] as String? ?? '');

  final String id;
  final String name;
  final String barCode;
  final List<Price> prices;
  Map<String, Object> toJson() {
    return {
      'name': name,
      'prices': prices.map((e) => e.toJson()),
      'barCode': barCode
    };
  }
}
