import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:escanio_app/services/firebase.dart';
import 'package:intl/intl.dart';

class HistoryService {
  static final collection = FirebaseService.fireStore
          .collection("history")
          // .doc(FirebaseService.currentUser!.uid)
          .doc("QJM3c3Lt3EdCrZb9bskO0lZtKkC3")
          .collection("dates")
      // .withConverter<HistoryDate>(
      //   fromFirestore: (snapshot, _) => HistoryDate.fromJson(snapshot.data()!),
      //   toFirestore: (history, _) => history.toJson(),
      // )
      ;

  static final _today = DateFormat("yyyy-MM-dd").format(DateTime.now());

  static getNext(DocumentSnapshot? startAfter) {
    return startAfter != null
        ? collection.startAfterDocument(startAfter).snapshots()
        : collection.snapshots();
  }
}

class HistoryDate {
  HistoryDate({required this.products, required this.date});

  HistoryDate.fromJson(Map<String, Object?> json)
      : this(
          products: (json["products"]! as List<dynamic>).map((p) {
            return HistoryProduct.fromJson(p);
          }).toList(),
          date: json["date"] as Timestamp,
        );

  final List<HistoryProduct> products;
  final Timestamp date;

  Map<String, Object?> toJson() {
    return {'products': products, 'date': date};
  }
}

class HistoryProduct {
  HistoryProduct({required this.name, required this.price});

  HistoryProduct.fromJson(Map<String, Object?> json)
      : this(
          name: json['name']! as String,
          price: json['price']! as num,
        );

  final String name;
  final num price;

  Map<String, Object?> toJson() {
    return {
      'name': name,
      'price': price,
    };
  }
}
