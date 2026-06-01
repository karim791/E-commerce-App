import 'package:e_commerce_app/models/categories_model.dart';
import 'package:e_commerce_app/models/home_carousel_item.dart';
import 'package:e_commerce_app/models/product_item_model.dart';
import 'package:e_commerce_app/services/firestore_services.dart';
import 'package:e_commerce_app/utilities/api_paths.dart';

abstract class HomeServices {
  Future<List<ProductItemsModel>> fetchProducts();
  Future<List<HomeCarouselItemModel>> fetchFeaturedProducts();
  Future<List<CategoriesModel>> fetchCategories();
  
}

class HomeServicesImpl implements HomeServices {
  final firestoreServices = FirestoreServices.instance;

  @override
  Future<List<ProductItemsModel>> fetchProducts() async {
    final result = await firestoreServices.getCollection<ProductItemsModel>(
      path: ApiPaths.products(),
      builder: (data, documentId) => ProductItemsModel.fromMap(data),
    );
    return result;
  }

  @override
  Future<List<HomeCarouselItemModel>> fetchFeaturedProducts() async {
    final result = await firestoreServices.getCollection<HomeCarouselItemModel>(
      path: ApiPaths.announcement(),
      builder: (data, documentId) => HomeCarouselItemModel.fromMap(data),
    );
    return result;
  }

  @override
  Future<List<CategoriesModel>> fetchCategories() async {
    final result = await firestoreServices.getCollection<CategoriesModel>(
      path: ApiPaths.categories(),
      builder: (data, documentId) => CategoriesModel.fromMap(data),
    );
    return result;
  }

 
}
