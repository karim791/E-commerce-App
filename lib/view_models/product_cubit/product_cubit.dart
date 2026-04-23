import 'package:e_commerce_app/models/add_to_cart.dart';
import 'package:e_commerce_app/models/product_item_model.dart';
import 'package:e_commerce_app/services/product_details_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitial());
  ProductSize? selectedSize;
  int quantity = 1;
  bool? onTap;

  final productDetail = ProductDetailsServicesImpl();

  void getProductById(String id) async {
    emit(ProductLoading());
    try {
      final selectedProduct = await productDetail.fetchProductDetails(id);
      emit(ProductLoaded(product: selectedProduct));
    } catch (e) {
      emit(ProductError(e.toString()));
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
