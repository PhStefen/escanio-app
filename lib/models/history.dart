import 'package:cloud_firestore/cloud_firestore.dart';

class History {
  History({required this.id, required this.date});

  History.fromJson(Map<String, Object?> json)
      : this(
          id: json['id']! as String,
          date: json['date']! as Timestamp,
        );

  final String id;
  final Timestamp date;
  Map<String, Object?> toJson() {
    return {
      'date': date,
    };
  }
}