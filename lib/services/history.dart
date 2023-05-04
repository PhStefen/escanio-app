import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:escanio_app/models/history.dart';
import 'package:escanio_app/services/firebase.dart';

class HistoryService {
  static final collection = FirebaseService.fireStore
      .collection("history")
      // .doc(FirebaseService.currentUser!.uid)
      .doc("QJM3c3Lt3EdCrZb9bskO0lZtKkC3")
      .collection("dates")
      .orderBy("date", descending: true)
      .withConverter<History>(
        fromFirestore: (snapshot, _) => History.fromJson(snapshot.data()!),
        toFirestore: (history, _) => history.toJson(),
      );

  static Stream<QuerySnapshot<History>> getNext() {
    return collection.snapshots();
  }

  static Future<QuerySnapshot<History>> getAll() {
    return collection.get();
  }
}
