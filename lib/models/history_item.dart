import 'package:cloud_firestore/cloud_firestore.dart';

class HistoryItem {
  HistoryItem({required this.createdAt, required this.id});

  HistoryItem.fromJson(Map<String, Object?> json)
      : this(
            createdAt: json['createdAt']! as Timestamp,
            id: json["id"]! as String);

  final Timestamp createdAt;
  final String id;
  Map<String, Object?> toJson() {
    return {'createdAt': createdAt};
  }
}
