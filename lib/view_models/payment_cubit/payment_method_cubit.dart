import 'package:e_commerce_app/models/payment_card_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'payment_method_state.dart';

class PaymentMethodCubit extends Cubit<PaymentMethodState> {
  PaymentMethodCubit() : super(PaymentMethodInitial());

  String? selectedId;

  void getCard(
    String cardNumber,
    String holderName,
    String expiryDate,
    String cvvNumber,
  ) {
    emit(PaymentMethodLoading());
    final cardModel = PaymentCardModel(
      id: DateTime.now().toIso8601String(),
      cardNumber: cardNumber,
      holderName: holderName,
      expiryDate: expiryDate,
      cvvNumber: cvvNumber,
    );

    Future.delayed(Duration(seconds: 1), () {
      paymentCards.add(cardModel);
      emit(PaymentMethodSuccess());
    });
  }

  void fetchPaymentMethod() {
    emit(FetchingPaymentMethod());
    Future.delayed(Duration(seconds: 1), () {
      final choosenCard = paymentCards.firstWhere(
        (paymentCard) => paymentCard.isChoosen == true,
        orElse: () => paymentCards.first,
      );
      emit(FetchedPaymentMethod(paymentCards: paymentCards));
      emit(ChosenCardMethod(choosenCard));
    });
  }

  void chosenCardMethod(String id) {
    selectedId = id;
    emit(PaymentMethodCardSelected(id));
  }

  void confirmCard() {
    final int previousIndex = paymentCards.indexWhere(
      (paymentCard) => paymentCard.isChoosen == true,
    );

    if (previousIndex != -1) {
      paymentCards[previousIndex] = paymentCards[previousIndex].copyWith(
        isChoosen: false,
      );
    }

    final int chosenIndex = paymentCards.indexWhere(
      (paymentCard) => paymentCard.id==selectedId,
    );

    if (chosenIndex != -1) {
      paymentCards[chosenIndex] = paymentCards[chosenIndex].copyWith(
        isChoosen: true,
      );
    }

    emit(ConfirmCardMethod(paymentCards[chosenIndex]));
  }
}
