import 'package:escanio_app/models/products.dart';
import 'package:escanio_app/services/firebase.dart';

class ProductsService {
  static var collection =
      FirebaseService.fireStore.collection("products").withConverter<Product>(
            fromFirestore: (snapshot, _) =>
                Product.fromJson({...snapshot.data()!, "id": snapshot.id}),
            toFirestore: (model, _) => model.toJson(),
          );
}
