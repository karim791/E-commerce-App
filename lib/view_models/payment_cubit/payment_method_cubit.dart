import 'package:e_commerce_app/models/payment_card_model.dart';
import 'package:e_commerce_app/services/checkout_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'payment_method_state.dart';

class PaymentMethodCubit extends Cubit<PaymentMethodState> {
  PaymentMethodCubit() : super(PaymentMethodInitial());

  final checkoutServices = CheckoutServicesImpl();

  String? selectedId;

  Future<void> getCard(
    String cardNumber,
    String holderName,
    String expiryDate,
    String cvvNumber,
  ) async{
    emit(PaymentMethodLoading());
    try{
      final cardModel = PaymentCardModel(
      id: DateTime.now().toIso8601String(),
      cardNumber: cardNumber,
      holderName: holderName,
      expiryDate: expiryDate,
      cvvNumber: cvvNumber,
    );
    await checkoutServices.setPaymentCard(cardModel);
    emit(PaymentMethodSuccess()); 
    }catch(e){
      emit(PaymentMethodFailure(e.toString()));
    }
   
  }


  Future<void> fetchPaymentMethod() async {
    emit(FetchingPaymentMethod());
    try{
      final paymentCards = await checkoutServices.fetchPaymentCards();
      emit(FetchedPaymentMethod(paymentCards: paymentCards));
      final choosenCard = paymentCards.firstWhere(
        (paymentCard) => paymentCard.isChoosen == true,
        orElse: () => paymentCards.first,
      );
      selectedId = choosenCard.id;
      emit(ChosenCardMethod(choosenCard));

    }catch(e){
      emit(PaymentMethodFailure(e.toString()));
    }
  
  }
  

    Future<void> changePaymentMethod(String id) async {
    selectedId = id;
    try {
      final tempChosenPaymentMethod =
          await checkoutServices.chosenPaymentCard(
        selectedId!,
      );
      emit(ChosenCardMethod(tempChosenPaymentMethod));
    } catch (e) {
      emit(PaymentMethodFailure(e.toString()));
    }
  }

  Future<void> confirmCard() async {
    emit(ConfirmingCardMethod());
    try{
     final previousChosenCard = await checkoutServices.fetchPaymentCards(true);
      final updatedPreviousChosenCard = previousChosenCard.first.copyWith(isChoosen: false);
      final currentChosenCard = await checkoutServices.chosenPaymentCard(selectedId!);
      final updatedCurrentChosenCard = currentChosenCard.copyWith(isChoosen: true);
      await checkoutServices.setPaymentCard(updatedPreviousChosenCard);
      await checkoutServices.setPaymentCard(updatedCurrentChosenCard);
      emit(ConfirmCardMethod(updatedCurrentChosenCard));

    }catch(e){
      emit(ConfirmingCardMethodError(e.toString()));
    }
  }
}
