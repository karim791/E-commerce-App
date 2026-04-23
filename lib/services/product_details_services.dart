import 'package:e_commerce_app/models/add_to_cart.dart';
import 'package:e_commerce_app/models/product_item_model.dart';
import 'package:e_commerce_app/services/auth_services.dart';
import 'package:e_commerce_app/services/firestore_services.dart';
import 'package:e_commerce_app/utilities/api_paths.dart';

abstract class ProductDetailsServices {
  Future<ProductItemsModel> fetchProductDetails(String id);
  Future<void> addToCart(AddToCartModel cartItem);
}

class ProductDetailsServicesImpl implements ProductDetailsServices {
  final firestore = FirestoreServices.instance;
  final authServices = AuthServicesImpl();

  @override
  Future<ProductItemsModel> fetchProductDetails(String id) async {
    final result = await firestore.getDocument<ProductItemsModel>(
      path: ApiPaths.product(id),
      buider: (data, documentId) => ProductItemsModel.fromMap(data),
    );
    return result;
  }

  @override
  Future<void> addToCart(AddToCartModel cartItem) async {
    await firestore.setDate(
      path: ApiPaths.cartItem(authServices.user()!.uid, cartItem.id),
      data: cartItem.toMap(),
    );
  }
}
