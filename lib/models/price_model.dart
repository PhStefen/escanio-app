import 'package:cloud_firestore/cloud_firestore.dart';

class PriceModel {
  PriceModel({required this.date, required this.value});

  PriceModel.fromJson(Map<String, Object?> json)
      : this(
          date: json['date']! as Timestamp,
          value: json['value']! as num,
        );

  final Timestamp date;
  final num value;
  Map<String, Object?> toJson() {
    return {
      'date': date,
      'value': value,
    };
  }
}
