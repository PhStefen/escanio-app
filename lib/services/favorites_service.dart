import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:escanio_app/services/firebase.dart';

class FavoritesService {
  static var collection = FirebaseService.fireStore
      .collection("users")
      // .doc(FirebaseService.getUser())
      .doc("bHI3ZZCNJUcItrdVhIMquKXv9Mk2")
      .collection("favorites");

  static getAll() {
    return collection.orderBy("createdAt");
  }

  static post(String productId) {
    collection.doc(productId).set({"createdAt": Timestamp.now()});
  }

  static delete(String productId) {
    collection.doc(productId).delete();
  }
}
