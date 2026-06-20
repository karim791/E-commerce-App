import 'package:e_commerce_app/models/add_to_cart.dart';
import 'package:e_commerce_app/models/address_item_model.dart';
import 'package:e_commerce_app/models/payment_card_model.dart';
import 'package:e_commerce_app/services/cart_services.dart';
import 'package:e_commerce_app/services/checkout_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit() : super(CheckoutInitial());

  final checkoutServices = CheckoutServicesImpl();
  final cartServices = CartServicesImpl();

  Future<void> getCheckout() async {
    emit(CheckoutLoading());
    try {
      final cartItems = await cartServices.fetchCartItem();
      final paymentCards = await checkoutServices.fetchPaymentCards();
      final locations = await checkoutServices.fetchLocations();
      final subtotal = cartItems.fold<double>(
        0,
        (previous, item) => previous+(item.product.price * item.quantity),
      );
      final int amount = cartItems.fold(
        0,
        (previous, item) => previous + item.quantity,
      );
      final choosenCard = paymentCards.firstWhere(
        (paymentCard) => paymentCard.isChoosen == true,
        orElse: () => paymentCards.first,
      );
      final AddressItemModel? chosenLocation =locations.isNotEmpty? locations.firstWhere(
        (location) => location.isChosen == true,
        orElse: () => locations.first,
      ):null;
      emit(
        CheckoutLoaded(
          cartItem: cartItems,
          subtotal: subtotal,
          amount: amount,
          paymentCard: choosenCard,
          location: chosenLocation,
        ),
      );
    } catch (e) {
      emit(CheckoutError(e.toString()));
    }
  }
}
