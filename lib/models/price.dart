import 'package:cloud_firestore/cloud_firestore.dart';

class Price {
  Price({required this.createdAt, required this.value});

  Price.fromJson(Map<String, Object?> json)
      : this(
          createdAt: json['createdAt']! as Timestamp,
          value: json['value']! as double,
        );

  final Timestamp createdAt;
  final double value;
  Map<String, Object?> toJson() {
    return {
      'createdAt': createdAt,
      'value': value,
    };
  }
}
