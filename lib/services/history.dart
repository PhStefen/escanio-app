import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:escanio_app/models/history.dart';
import 'package:escanio_app/models/products.dart';
import 'package:escanio_app/services/firebase.dart';

class HistoryService {
  static final collection = FirebaseService.fireStore
      .collection("users")
      .doc(FirebaseService.currentUser!.uid)
      .collection("history");

  static Future<QuerySnapshot<Product>> getProducts(String id) {
    return collection
        .doc(id)
        .collection("products")
        .withConverter<Product>(
          fromFirestore: (snapshot, _) =>
              Product.fromJson({...snapshot.data()!, "id": snapshot.id}),
          toFirestore: (model, _) => model.toJson(),
        )
        .get();
  }

  static Future<QuerySnapshot<History>> getAll() {
    return collection
        .withConverter<History>(
          fromFirestore: (snapshot, _) =>
              History.fromJson({...snapshot.data()!, "id": snapshot.id}),
          toFirestore: (model, _) => model.toJson(),
        )
        .get();
  }
}
