import 'package:e_commerce_app/models/add_to_cart.dart';
import 'package:e_commerce_app/models/product_item_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitial());
  ProductSize? selectedSize;
  int quantity = 1;
  bool? onTap;

  void getProductById(String id) {
    emit(ProductLoading());

    Future.delayed(const Duration(seconds: 1), () {
      final product = dummyProducts.firstWhere((product) => product.id == id);
      emit(ProductLoaded(product: product));
    });
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

  void addToCart(String productId) {
    emit(AddToCartLoading());

    final cartItem = AddToCart(
      id: DateTime.now().toIso8601String(),
      product: dummyProducts.firstWhere((item) => item.id == productId),
      size: selectedSize!,
      quantity: quantity,
      totalPrice:
          dummyProducts.firstWhere((item) => item.id == productId).price * quantity,
    );
    dummyCart.add(cartItem);

    Future.delayed(const Duration(seconds: 1), () {
      emit(AddToCartLoaded(productId: productId));
    });
  }
}
