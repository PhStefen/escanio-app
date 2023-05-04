import 'package:cloud_firestore/cloud_firestore.dart';

class Favorite {
  Favorite({required this.name, required this.date});

  Favorite.fromJson(Map<String, Object?> json)
      : this(
          name: json['name']! as String,
          date: json['date']! as Timestamp,
        );

  final String name;
  final Timestamp date;

  Map<String, Object?> toJson() {
    return {
      'name': name,
      'date': date,
    };
  }
}
