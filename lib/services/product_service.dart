import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:escanio_app/models/product_model.dart';

class ProductsService {
  static CollectionReference<ProductModel> get collection => FirebaseFirestore.instance.collection("products").withConverter<ProductModel>(
        fromFirestore: (snapshot, _) => ProductModel.fromJson({
          'id': snapshot.id,
          ...snapshot.data()!,
        }),
        toFirestore: (model, _) => model.toJson(),
      );

  static Future<DocumentSnapshot<ProductModel>> get(String productId) {
    return collection
        .doc(productId)
        .withConverter<ProductModel>(
          fromFirestore: (snapshot, _) => ProductModel.fromJson({...snapshot.data()!, "id": snapshot.id}),
          toFirestore: (model, _) => model.toJson(),
        )
        .get();
  }

  static Future set(ProductModel product) async {
    await collection.doc(product.id).set(product);
  }

  static Future<QuerySnapshot<ProductModel>> scan(String barCode) {
    return collection
        .where("barCode", isEqualTo: barCode)
        .withConverter<ProductModel>(
          fromFirestore: (snapshot, _) => ProductModel.fromJson({...snapshot.data()!, "id": snapshot.id}),
          toFirestore: (model, _) => model.toJson(),
        )
        .get();
  }
}
