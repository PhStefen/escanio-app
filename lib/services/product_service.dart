import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:escanio_app/models/product_model.dart';

class ProductsService {
  static CollectionReference<ProductModel> get collection =>
      FirebaseFirestore.instance
          .collection("products")
          .withConverter<ProductModel>(
            fromFirestore: (snapshot, _) {
              var data = snapshot.data();
              return ProductModel.fromJson({
                'id': snapshot.id,
                ...data!,
                "prices": data["prices"] ?? []
              });
            },
            toFirestore: (model, _) => model.toJson(),
          );

  static Future<DocumentSnapshot<ProductModel>> get(String productId) {
    return collection
        .doc(productId)
        .get();
  }

  static Future set(ProductModel product) async {
    await collection.doc(product.id).set(product);
  }

  static Future<QuerySnapshot<ProductModel>> scan(String barCode) {
    return collection
        .where("barCode", isEqualTo: barCode)
        .get();
  }
}
