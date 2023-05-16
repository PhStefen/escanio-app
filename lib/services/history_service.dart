import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:escanio_app/models/history.dart';
import 'package:escanio_app/models/history_item.dart';
import 'package:escanio_app/services/firebase.dart';

class HistoryService {
  static final collection = FirebaseService.fireStore
      .collection("users")
      // .doc(FirebaseService.getUser()!.uid)
      .doc("bHI3ZZCNJUcItrdVhIMquKXv9Mk2")
      .collection("history")
      .withConverter<History>(
        fromFirestore: (snapshot, _) => History.fromJson(snapshot.data()!),
        toFirestore: (model, _) => model.toJson(),
      );

  static Stream<QuerySnapshot<HistoryItem>> getItems(String id) {
    return collection
        .doc(id)
        .collection("items")
        .withConverter<HistoryItem>(
          fromFirestore: (snapshot, _) => HistoryItem.fromJson({...snapshot.data()!, "id": snapshot.id}),
          toFirestore: (model, _) => model.toJson(),
        )
        .orderBy("createdAt", descending: true)
        .snapshots();
  }

  static Query<History> getAll() {
    return collection.orderBy("createdAt", descending: true);
  }
}
