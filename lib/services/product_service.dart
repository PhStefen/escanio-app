import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:escanio_app/models/product_model.dart';

class ProductsService {
  static Future<DocumentSnapshot<ProductModel>> get(String productId) {
    return FirebaseFirestore.instance
        .collection("products")
        .doc(productId)
        .withConverter<ProductModel>(
          fromFirestore: (snapshot, _) =>
              ProductModel.fromJson({...snapshot.data()!, "id": snapshot.id}),
          toFirestore: (model, _) => model.toJson(),
        )
        .get();
  }

  static Future<QuerySnapshot<ProductModel>> scan(String barCode) {
    return FirebaseFirestore.instance
        .collection("products")
        .where("barCode", isEqualTo: barCode)
        .withConverter<ProductModel>(
          fromFirestore: (snapshot, _) =>
              ProductModel.fromJson({...snapshot.data()!, "id": snapshot.id}),
          toFirestore: (model, _) => model.toJson(),
        )
        .get();
  }
}
