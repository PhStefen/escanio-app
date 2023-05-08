import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:escanio_app/models/products.dart';
import 'package:escanio_app/services/firebase.dart';

class FavoritesService {
  static final collection = FirebaseService.fireStore
      .collection("users")
      .doc(FirebaseService.getUser()!.uid)
      .collection("favorites")
      .withConverter<Product>(
        fromFirestore: (snapshot, _) =>
            Product.fromJson({...snapshot.data()!, "id": snapshot.id}),
        toFirestore: (model, _) => model.toJson(),
      );

  static Stream<QuerySnapshot<Product>> getAll() {
    return collection.snapshots();
  }

  static delete(Product product) async {
    await collection.doc(product.id).delete();
  }

  static add(Product product) async {
    await collection.doc(product.id).set(product);
  }
}
