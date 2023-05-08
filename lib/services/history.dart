import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:escanio_app/models/history.dart';
import 'package:escanio_app/models/products.dart';
import 'package:escanio_app/services/firebase.dart';

class HistoryService {
  static final collection = FirebaseService.fireStore
      .collection("users")
      // .doc(FirebaseService.getUser()!.uid)
      .doc("bHI3ZZCNJUcItrdVhIMquKXv9Mk2")
      .collection("history");

  static Future<List<DocumentSnapshot<Product>>> getProducts(String id) async {
    var itemsSnapshot = await collection.doc(id).collection("items").get();
    var items = itemsSnapshot.docs.map((e) => e.data()).toList();

    return Future.wait(items.map((e) {
      DocumentReference ref = e["product"];
      return ref
          .withConverter<Product>(
            fromFirestore: (snapshot, _) =>
                Product.fromJson({...snapshot.data()!, "id": snapshot.id}),
            toFirestore: (model, _) => model.toJson(),
          )
          .get();
    }));
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
