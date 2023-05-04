import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:escanio_app/models/favorites.dart';
import 'package:escanio_app/services/firebase.dart';

class FavoritesService {
  static final collection = FirebaseService.fireStore
      .collection("favorites")
      // .doc(FirebaseService.currentUser!.uid)
      .doc("QJM3c3Lt3EdCrZb9bskO0lZtKkC3")
      .collection("products")
      .withConverter<Favorite>(
        fromFirestore: (snapshot, _) => Favorite.fromJson(snapshot.data()!),
        toFirestore: (model, _) => model.toJson(),
      );

  static Stream<QuerySnapshot<Favorite>> getAll() {
    return collection.snapshots();
  }

  static delete(String id) {
    collection.doc(id).delete();
  }

  static add(String id, String name) {
    var favorite = Favorite(name: name, date: Timestamp.now());
    collection.doc(id).set(favorite);
  }
}
