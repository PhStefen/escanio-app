import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:escanio_app/models/history_model.dart';
import 'package:escanio_app/services/auth_service.dart';

class HistoryService {
  static CollectionReference<HistoryModel> get collection =>
      FirebaseFirestore.instance
          .collection("users")
          // .doc(AuthService.user?.uid)
          .doc("NkPU5wChq7feuoEGgQujRGp1UQi1")
          .collection("history")
          .withConverter<HistoryModel>(
            fromFirestore: (snapshot, _) => HistoryModel.fromJson({
              'id': snapshot.id,
              ...snapshot.data()!,
            }),
            toFirestore: (model, _) => model.toJson(),
          );

  static Stream<QuerySnapshot<HistoryModel>> get all {
    return collection.snapshots();
  }
}
