import 'package:cloud_firestore/cloud_firestore.dart';

class History {
  History({required this.createdAt});

  History.fromJson(Map<String, Object?> json)
      : this(
          createdAt: json['createdAt']! as Timestamp,
        );

  final Timestamp createdAt;
  Map<String, Object?> toJson() {
    return {
      'createdAt': createdAt,
    };
  }
}
