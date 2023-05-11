import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:escanio_app/models/price.dart';
import 'package:escanio_app/models/products.dart';
import 'package:escanio_app/services/firebase.dart';

class ProductsService {
  static var collection =
      FirebaseService.fireStore.collection("products").withConverter<Product>(
            fromFirestore: (snapshot, _) =>
                Product.fromJson({...snapshot.data()!, "id": snapshot.id}),
            toFirestore: (model, _) => model.toJson(),
          );

  static Future<QuerySnapshot<Price>> getPrices(String id) {
    return collection
        .doc(id)
        .collection("prices")
        .withConverter<Price>(
          fromFirestore: (snapshot, _) =>
              Price.fromJson({...snapshot.data()!, "id": snapshot.id}),
          toFirestore: (model, _) => model.toJson(),
        )
        .orderBy("createdAt", descending: true)
        .get();
  }
}
