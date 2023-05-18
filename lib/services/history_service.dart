import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:escanio_app/models/history.dart';
import 'package:escanio_app/models/products.dart';
import 'package:escanio_app/services/firebase.dart';
import 'package:flutter/material.dart';

class HistoryService {
  static final collection = FirebaseService.fireStore
      .collection('users')
      // .doc(FirebaseService.getUser()!.uid)
      .doc('bHI3ZZCNJUcItrdVhIMquKXv9Mk2')
      .collection('history')
      .withConverter<History>(
        fromFirestore: (snapshot, _) => History.fromJson({
          'id': snapshot.id,
          ...snapshot.data()!,
        }),
        toFirestore: (model, _) => model.toJson(),
      );

  static Stream<QuerySnapshot<History>> getAll() {
    return collection.orderBy('lastUpdate', descending: true).snapshots();
  }

  static void add(Product product) {
    var history = History.fromJson({
      'lastUpdate': DateUtils.dateOnly(DateTime.now()),
      ...product.toJson(),
    });
    collection.doc(product.id).set(history);
  }
}
