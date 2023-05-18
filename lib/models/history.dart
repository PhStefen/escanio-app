import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:escanio_app/models/price.dart';
import 'package:escanio_app/models/products.dart';

class History extends Product {
  History({
    required String name,
    required List<Price> prices,
    required bool isFavourite,
    required this.lastUpdate,
  }) : super(name: name, prices: prices, isFavourite: isFavourite);

  final Timestamp lastUpdate;

  factory History.fromJson(Map<String, dynamic> json) {
    return History(
      name: json['name'] as String,
      prices: (json['prices'] as List<dynamic>)
          .map((json) => Price.fromJson(json))
          .toList(),
      isFavourite: json['isFavourite'] as bool,
      lastUpdate: json['lastUpdate'] as Timestamp,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    data['lastUpdate'] = lastUpdate;
    return data;
  }
}
