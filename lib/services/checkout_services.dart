import 'package:e_commerce_app/models/address_item_model.dart';
import 'package:e_commerce_app/models/payment_card_model.dart';
import 'package:e_commerce_app/services/auth_services.dart';
import 'package:e_commerce_app/services/firestore_services.dart';
import 'package:e_commerce_app/utilities/api_paths.dart';

abstract class CheckoutServices {
  Future<List<PaymentCardModel>> fetchPaymentCards([bool isChosenCard]);
  Future<PaymentCardModel> chosenPaymentCard(String cardId);
  Future<void> setPaymentCard(PaymentCardModel card);
  Future<List<AddressItemModel>> fetchLocations([bool isChosen]);
  Future<AddressItemModel> chosenLocation(String locationId);
  Future<void> setLocation(AddressItemModel location);
}

class CheckoutServicesImpl implements CheckoutServices {
  final fireStoreServices = FirestoreServices.instance;
  final authServices = AuthServicesImpl();

  @override
  Future<List<PaymentCardModel>> fetchPaymentCards([
    bool isChosenCard = false,
  ]) async {
    final result = await fireStoreServices.getCollection(
      path: ApiPaths.paymentCards(authServices.user()!.uid),
      builder: (data, documentId) => PaymentCardModel.fromMap(data),
      queryBuilder: isChosenCard
          ? (query) => query.where('isChoosen', isEqualTo: true)
          : null,
    );
    return result;
  }

  @override
  Future<void> setPaymentCard(PaymentCardModel card) async {
    await fireStoreServices.setDate(
      path: ApiPaths.paymentCard(authServices.user()!.uid, card.id),
      data: card.toMap(),
    );
  }

  @override
  Future<PaymentCardModel> chosenPaymentCard(String cardId) async {
    final chosenCard = await fireStoreServices.getDocument(
      path: ApiPaths.paymentCard(authServices.user()!.uid, cardId),
      builder: (data, documentId) => PaymentCardModel.fromMap(data),
    );

    return chosenCard;
  }

  @override
  Future<void> setLocation(AddressItemModel location) async =>
      await fireStoreServices.setDate(
        path: ApiPaths.location(authServices.user()!.uid, location.id),
        data: location.toMap(),
      );
  @override
  Future<AddressItemModel> chosenLocation(String locationId) async =>
      await fireStoreServices.getDocument(
        path: ApiPaths.location(authServices.user()!.uid, locationId),
        builder: ((data, documentId) => AddressItemModel.fromMap(data)),
      );

  @override
  Future<List<AddressItemModel>> fetchLocations([bool isChosen=false]) async =>
      await fireStoreServices.getCollection(
        path: ApiPaths.locations(authServices.user()!.uid),
        builder: (data, documentId) => AddressItemModel.fromMap(data),
        queryBuilder: isChosen?(query) => query.where('isChosen',isEqualTo: true):null,
      );
}
