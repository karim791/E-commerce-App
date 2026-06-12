import 'package:e_commerce_app/models/add_to_cart.dart';
import 'package:e_commerce_app/services/auth_services.dart';
import 'package:e_commerce_app/services/firestore_services.dart';
import 'package:e_commerce_app/utilities/api_paths.dart';

abstract class CartServices {
  Future<List<AddToCartModel>> fetchCartItem();
  Future<void> addToCart(AddToCartModel cartItem);
  Future<void> removeFromCart(AddToCartModel cartItem);
}

class CartServicesImpl implements CartServices {
  final firestoreServices = FirestoreServices.instance;
  final authServices = AuthServicesImpl();

  @override
  Future<List<AddToCartModel>> fetchCartItem() async {
    final result = await firestoreServices.getCollection(
      path:
          ApiPaths.cartItems(authServices.user()!.uid), // Replace 'current_user_id' with the actual user ID
      builder: (data, documentId) => AddToCartModel.fromMap(data, documentId),
    );
    return result;
  }
  
  @override
  Future<void> addToCart(AddToCartModel cartItem) async {
    await firestoreServices.setDate(
      path: ApiPaths.cartItem(authServices.user()!.uid, cartItem.id), // Replace 'current_user_id' with the actual user ID and use cartItem.id for the document ID
      data: cartItem.toMap(),
    );
  }
  
  @override
  Future<void> removeFromCart(AddToCartModel cartItem) async {
    await firestoreServices.deleteData(
      path: ApiPaths.cartItem(authServices.user()!.uid, cartItem.id), // Replace 'current_user_id' with the actual user ID and use cartItem.id for the document ID
    );
  }
}
