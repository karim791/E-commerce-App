part of 'checkout_cubit.dart';

sealed class CheckoutState {}

final class CheckoutInitial extends CheckoutState {}

final class CheckoutLoading extends CheckoutState {}

final class CheckoutLoaded extends CheckoutState {
  final List<AddToCart> cartItem;
  final double subtotal;
  final int amount;
  final PaymentCardModel? paymentCard;
  final AddressItemModel? location;
  CheckoutLoaded({
    required this.cartItem,
    required this.subtotal,
    required this.amount,
    this.paymentCard,
    this.location,
  });
}

final class CheckoutError extends CheckoutState {
  final String message;

  CheckoutError(this.message);
}

final class ChosenCard extends CheckoutState {
  final PaymentCardModel? chosenPaymentCard;

  ChosenCard(this.chosenPaymentCard);
}
