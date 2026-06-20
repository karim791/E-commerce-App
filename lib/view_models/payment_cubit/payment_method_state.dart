part of 'payment_method_cubit.dart';

sealed class PaymentMethodState {}

final class PaymentMethodInitial extends PaymentMethodState {}

final class PaymentMethodLoading extends PaymentMethodState {}

final class PaymentMethodSuccess extends PaymentMethodState {}

final class PaymentMethodFailure extends PaymentMethodState {
  final String errorMessage;

  PaymentMethodFailure(this.errorMessage);
}

final class FetchingPaymentMethod extends PaymentMethodState {}

final class FetchedPaymentMethod extends PaymentMethodState {
  final List<PaymentCardModel> paymentCards;

  FetchedPaymentMethod({required this.paymentCards});
}

final class FetchingPaymentMethodFailure extends PaymentMethodState {
  final String message;

  FetchingPaymentMethodFailure(this.message);
}

final class ChosenCardMethod extends PaymentMethodState {
  final PaymentCardModel choosenCard;

  ChosenCardMethod(this.choosenCard);
}

final class ConfirmingCardMethod extends PaymentMethodState {}

final class ConfirmCardMethod extends PaymentMethodState {
  final PaymentCardModel choosenCard;

  ConfirmCardMethod(this.choosenCard);
}

final class ConfirmingCardMethodError extends PaymentMethodState {
  final String message;
  ConfirmingCardMethodError(this.message);
}
