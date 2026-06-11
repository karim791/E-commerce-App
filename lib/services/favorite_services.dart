import 'package:e_commerce_app/models/product_item_model.dart';
import 'package:e_commerce_app/services/auth_services.dart';
import 'package:e_commerce_app/services/firestore_services.dart';
import 'package:e_commerce_app/utilities/api_paths.dart';

abstract class FavoriteServices {
  Future<List<ProductItemsModel>> fetchFavoriteProducts();
  Future<void> addToFavorites(ProductItemsModel product);
  Future<void> removeFromFavorites(ProductItemsModel product);
}

class FavoriteServicesImpl implements FavoriteServices {
  final firestoreServices = FirestoreServices.instance;
  final authServices = AuthServicesImpl();

  @override
  Future<List<ProductItemsModel>> fetchFavoriteProducts() async {
    final result = await firestoreServices.getCollection(
      path: ApiPaths.favoriteItems(authServices.user()!.uid),
      builder: (data, documentId) => ProductItemsModel.fromMap(data),
    );
    return result;
  }

  @override
  Future<void> addToFavorites(ProductItemsModel product) async {
    await firestoreServices.setDate(
      path: ApiPaths.favoriteItem(authServices.user()!.uid, product.id),
      data: product.toMap(),
    );
  }

  @override
  Future<void> removeFromFavorites(ProductItemsModel product) async {
    await firestoreServices.deleteData(
      path: ApiPaths.favoriteItem(authServices.user()!.uid, product.id),
    );
  }
}
