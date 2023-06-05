import 'package:escanio_app/models/price_model.dart';

class ProductModel {
  ProductModel({
    required this.id,
    required this.name,
    required this.prices,
    required this.barCode,
  });

  ProductModel.fromJson(Map<String, Object> json)
      : this(
            id: json['id'] as String,
            name: json['name'] as String? ?? '',
            prices: (json['prices'] as List<dynamic>? ?? [])
                .map((json) => PriceModel.fromJson(json))
                .toList(),
            barCode: json['barCode'] as String? ?? '');

  final String id;
  final String name;
  final String barCode;
  final List<PriceModel> prices;
  Map<String, Object> toJson() {
    return {
      'name': name,
      'prices': prices.map((e) => e.toJson()),
      'barCode': barCode
    };
  }
}
