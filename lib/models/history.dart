import 'package:cloud_firestore/cloud_firestore.dart';

class History {
  History({
    required this.id,
    required this.name,
    required this.price,
    required this.lastSeen,
    required this.isFavourite,
  });

  History.fromJson(Map<String, Object> json)
      : this(
          id: json['id'] as String,
          name: json['name'] as String,
          price: json['price'] as num,
          isFavourite: json['isFavourite'] as bool,
          lastSeen: json['lastSeen'] as Timestamp,
        );

  String id;
  String name;
  bool isFavourite;
  num price;
  Timestamp lastSeen;

  Map<String, Object> toJson() {
    return {
      'name': name,
      'isFavourite': isFavourite,
      'price': price,
      'lastSeen': lastSeen,
    };
  }
}
