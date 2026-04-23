
import 'package:e_commerce_app/models/product_item_model.dart';
import 'package:e_commerce_app/services/firestore_services.dart';
import 'package:e_commerce_app/utilities/api_paths.dart';

abstract class HomeServices {
  Future<List<ProductItemsModel>> fetchProducts();
  
}

class HomeServicesImpl implements HomeServices {
  final firestoreServices = FirestoreServices.instance;
 

  @override
  Future<List<ProductItemsModel>> fetchProducts() async {
    final result = await firestoreServices.getCollection<ProductItemsModel>(
      path: ApiPaths.products(),
      builder: (data, documentId) =>
          ProductItemsModel.fromMap(data),
    );
    return result;
  }

 
}
