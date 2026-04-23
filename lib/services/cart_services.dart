import 'package:e_commerce_app/models/add_to_cart.dart';
import 'package:e_commerce_app/services/firestore_services.dart';
import 'package:e_commerce_app/utilities/api_paths.dart';

abstract class CartServices {
  Future<List<AddToCartModel>> fetchCartItem();
}

class CartServicesImpl implements CartServices {
  final firestoreServices = FirestoreServices.instance;

  @override
  Future<List<AddToCartModel>> fetchCartItem() async {
    final result = await firestoreServices.getCollection(
      path: ApiPaths.cartItems(),
      builder: (data, documentId) => AddToCartModel.fromMap(data, documentId),
    );
    return result;
  }
}
