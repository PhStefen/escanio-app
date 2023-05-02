import 'dart:convert';

import 'package:escanio_app/services/firebase.dart';
import 'package:intl/intl.dart';

class HistoryService {
  static final collection = FirebaseService.fireStore
      .collection("history")
      .doc(FirebaseService.currentUser!.uid)
      .collection("dates")
      .withConverter<HistoryDate>(
        fromFirestore: (snapshot, _) => HistoryDate.fromJson(snapshot.data()!),
        toFirestore: (history, _) => history.toJson(),
      );

  static final _today = DateFormat("yyyy-MM-dd").format(DateTime.now());

  static Future add(String id, double value) async {
    var ref = collection.doc(_today);
    var snapshot = await ref.get();
    print(_today);
    print(snapshot.data()!.products.first.value);
  }
}

class HistoryDate {
  HistoryDate({required this.products});

  HistoryDate.fromJson(Map<String, Object?> json)
      : this(
          products: (json["products"]! as List<dynamic>).map((p) {
            print(p);
            return HistoryProduct.fromJson(p);
          }).toList(),
        );

  final List<HistoryProduct> products;

  Map<String, Object?> toJson() {
    return {'products': products};
  }
}

class HistoryProduct {
  HistoryProduct({required this.id, required this.value});

  HistoryProduct.fromJson(Map<String, Object?> json)
      : this(
          id: json['id']! as String,
          value: json['value']! as num,
        );

  final String id;
  final num value;

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'value': value,
    };
  }
}
