import 'package:e_commerce_app/models/add_to_cart.dart';
import 'package:e_commerce_app/services/cart_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  bool? onTap;
  int quantity=1;
  final cartServices = CartServicesImpl();

  Future<void> getCartData() async {
    emit(CartLoading());

    try {
      final cartItem = await cartServices.fetchCartItem();
      emit(CartLoaded(cartItem: cartItem, subtotal: _subtotal));
    } catch (e) {
      emit(CartError(errorMessage: e.toString()));
    }

    // Future.delayed(Duration(seconds: 1), () {
    //   emit(CartLoaded(cartItem: dummyCart, subtotal: _subtotal));
    // });
  }

  void incrementCounter(String id, [int? initialQuantity]) {
    if (initialQuantity != null) {
      quantity = initialQuantity;
    }
    quantity++;
    final int index = dummyCart.indexWhere((item) => item.product.id == id);
    dummyCart[index] = dummyCart[index].copyWith(quantity: quantity);
    emit(CounterLoaded(value: quantity, productId: id, onTap: true));
    emit(SubtotalUpdated(subtotal: _subtotal));
  }

  void decrementCounter(String id, [int? initialQuantity]) {
    if (initialQuantity != null) {
      quantity = initialQuantity;
    }

    if (quantity > 1) {
      quantity--;
      final int index = dummyCart.indexWhere((item) => item.product.id == id);
      dummyCart[index] = dummyCart[index].copyWith(quantity: quantity);
      emit(SubtotalUpdated(subtotal: _subtotal));
      emit(CounterLoaded(value: quantity, productId: id, onTap: false));
    }
  }

  double get _subtotal => dummyCart.fold<double>(
    0,
    (previous, item) => previous + (item.product.price * item.quantity),
  );
}
