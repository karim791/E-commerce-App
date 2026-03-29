import 'package:e_commerce_app/models/add_to_cart.dart';
import 'package:e_commerce_app/models/address_item_model.dart';
import 'package:e_commerce_app/models/payment_card_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit() : super(CheckoutInitial());

  void getCheckout() {
    emit(CheckoutLoading());
    Future.delayed(Duration(seconds: 1), () {
      final cartItem = dummyCart;
      final int amount = dummyCart.fold(
        0,
        (previous, item) => previous + item.quantity,
      );
      final subtotal = dummyCart.fold<double>(
        0,
        (previous, item) => previous + (item.quantity * item.product.price),
      );
      final PaymentCardModel? chosenPaymentCard = paymentCards.isNotEmpty
          ? paymentCards.firstWhere(
              (paymentCard) => paymentCard.isChoosen == true,
              orElse: () => paymentCards.first,
            )
          : null;
      final AddressItemModel? location = dummyLocations.isNotEmpty? dummyLocations.firstWhere(
        (location) => location.isChosen == true,orElse: () => dummyLocations.first,
      ):null;
      emit(
        CheckoutLoaded(
          cartItem: cartItem,
          subtotal: subtotal,
          amount: amount,
          paymentCard: chosenPaymentCard,
          location:location,
        ),
      );
    });
  }
}
