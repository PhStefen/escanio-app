import 'package:cloud_firestore/cloud_firestore.dart';

class Price {
  Price({required this.date, required this.value});

  Price.fromJson(Map<String, Object?> json)
      : this(
          date: json['date']! as Timestamp,
          value: json['value']! as double,
        );

  final Timestamp date;
  final double value;
  Map<String, Object?> toJson() {
    return {
      'date': date,
      'value': value,
    };
  }
}
