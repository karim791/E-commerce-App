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
      final cartItems = await cartServices.fetchCartItem();
      emit(CartLoaded(cartItem: cartItems, subtotal: _subtotal(cartItems)));
    } catch (e) {
      emit(CartError(errorMessage: e.toString()));
    }

  }

  Future<void> incrementCounter(AddToCartModel cartItem, int? initialQuantity) async {
    if (initialQuantity != null) {
      quantity = initialQuantity;
    }

     try{
      quantity++;
      final updatedCartItem = cartItem.copyWith(quantity: quantity);
      await cartServices.addToCart(updatedCartItem);
      emit(CounterLoaded(productId: cartItem.id, value: quantity, onTap: true));
      final cartItems = await cartServices.fetchCartItem();
    emit(SubtotalUpdated(subtotal: _subtotal(cartItems)));
     }catch(e){
      emit(CounterError(e.toString()));
    }
  }

  Future<void> decrementCounter(AddToCartModel cartItem, int? initialQuantity) async {
    if (initialQuantity != null) {
      quantity = initialQuantity;
    }
    try{
      if(quantity>1){
        quantity--;
        final updatedCartItem = cartItem.copyWith(quantity: quantity);
        await cartServices.addToCart(updatedCartItem);
        emit(CounterLoaded(productId: cartItem.id, value: quantity, onTap: false));
        final cartItems = await cartServices.fetchCartItem();
        emit(SubtotalUpdated(subtotal: _subtotal(cartItems)));
      }
    }catch(e){
      emit(CounterError(e.toString()));
    }

  }

  Future<void> removeFromCart(AddToCartModel cartItem) async {
    try{
      emit(RemoveFromCartLoading(productId: cartItem.id));
      await cartServices.removeFromCart(cartItem);
      emit(RemoveFromCartLoaded(productId: cartItem.id));
      final cartItems = await cartServices.fetchCartItem();
      emit(SubtotalUpdated(subtotal: _subtotal(cartItems)));
      emit(CartLoaded(cartItem: cartItems, subtotal: _subtotal(cartItems)));
    }catch(e){
      emit(RemoveFromCartError(e.toString(), productId: cartItem.id));
    }
  }

  double  _subtotal(List<AddToCartModel> cartItems) => cartItems.fold<double>(
    0,
    (previous, item) => previous + (item.product.price * item.quantity),
  );
}
