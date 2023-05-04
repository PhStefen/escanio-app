import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:escanio_app/models/products.dart';
import 'package:escanio_app/services/firebase.dart';

class ProductsService {
  static Query<Product> fromHistory(String historyId) {
    return FirebaseService.fireStore
        .collection("history")
        .doc("QJM3c3Lt3EdCrZb9bskO0lZtKkC3")
        .collection("dates")
        .doc(historyId)
        .collection("products")
        .orderBy("name")
        .withConverter<Product>(
          fromFirestore: (snapshot, _) => Product.fromJson({
            "id": snapshot.id,
            ...snapshot.data()!,
          }),
          toFirestore: (model, _) => model.toJson(),
        );
  }
}
