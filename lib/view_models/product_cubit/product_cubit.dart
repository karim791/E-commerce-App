import 'package:e_commerce_app/models/add_to_cart.dart';
import 'package:e_commerce_app/models/product_item_model.dart';
import 'package:e_commerce_app/services/favorite_services.dart';
import 'package:e_commerce_app/services/product_details_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitial());
  ProductSize? selectedSize;
  int quantity = 1;
  bool? onTap;

  final productDetail = ProductDetailsServicesImpl();
  final favoriteServices = FavoriteServicesImpl();

  void getProductById(String id) async {
    emit(ProductLoading());
    try {
      final selectedProduct = await productDetail.fetchProductDetails(id);
      final favoriteProducts = await favoriteServices.fetchFavoriteProducts();
      final isFavorite = favoriteProducts.any((item) => item.id == selectedProduct.id);
      emit(ProductLoaded(product: selectedProduct, isFavorite: isFavorite));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  Future<void> setFavorite(ProductItemsModel product) async {
    emit(SetFavoriteLoading(productId: product.id));
    try {
      final favoriteProducts = await favoriteServices.fetchFavoriteProducts();
      final isFavorite = favoriteProducts.any((item) => item.id == product.id);
      if (isFavorite) {
        await favoriteServices.removeFromFavorites(product);
      } else {
        await favoriteServices.addToFavorites(product);
      }
      emit(SetFavoriteSuccess(isFavorite: !isFavorite, productId: product.id));
    } catch (e) {
      emit(SetFavoriteError(message: e.toString(), productId: product.id));
    }
  }

  void incrementCounter(String id) {
    quantity++;
    emit(CounterLoaded(value: quantity, onTap: true));
  }

  void decrementCounter(String id) {
    if (quantity > 1) {
      quantity--;
      emit(CounterLoaded(value: quantity, onTap: false));
    }
  }

  void selectSize(ProductSize size) {
    selectedSize = size;
    emit(SizeSelected(size: size));
  }

  void addToCart(String productId) async {
    emit(AddToCartLoading());
    try {
      final selectedProduct = await productDetail.fetchProductDetails(
        productId,
      );
      final cartItem = AddToCartModel(
        id: DateTime.now().toIso8601String(),
        product: selectedProduct,
        size: selectedSize!,
        quantity: quantity,
      );
      await productDetail.addToCart(cartItem);
      emit(AddToCartLoaded(productId: productId));
    } catch (e) {
      emit(AddToCartError(e.toString()));
    }

    // final cartItem = AddToCartModel(
    //   id: DateTime.now().toIso8601String(),
    //   product: dummyProducts.firstWhere((item) => item.id == productId),
    //   size: selectedSize!,
    //   quantity: quantity,
    // );
    // dummyCart.add(cartItem);

    // Future.delayed(const Duration(seconds: 1), () {
    //   emit(AddToCartLoaded(productId: productId));
    // });
  }
}
