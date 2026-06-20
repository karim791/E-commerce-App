import 'package:e_commerce_app/models/address_item_model.dart';
import 'package:e_commerce_app/services/checkout_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'address_state.dart';

class AddressCubit extends Cubit<AddressState> {
  AddressCubit() : super(AddressInitial());

  String? selectedId;
  final checkoutServices = CheckoutServicesImpl();

  Future<void> fetchAddress() async {
    emit(FetchingLocation());
    try {
      final locations = await checkoutServices.fetchLocations();
      final AddressItemModel? chosenLocation = locations.isNotEmpty
          ? locations.firstWhere(
              (location) => location.isChosen == true,
              orElse: () => locations.first,
            )
          : null;
      selectedId = locations.isNotEmpty ? chosenLocation!.id : null;
      emit(FetchedLocation(locations));
      emit(ChosenLocation(chosenLocation));
    } catch (e) {
      emit(FetchingLocationFailure(e.toString()));
    }
  }

  Future<void> addingLocation(String location) async {
    emit(AddingLocation());
    try {
      final locations = location.split('-');
      final newLocation = AddressItemModel(
        id: DateTime.now().toIso8601String(),
        city: locations.first,
        country: locations.last,
      );
      await checkoutServices.setLocation(newLocation);
      emit(AddedLocation());
      final updatedLocations = await checkoutServices.fetchLocations();
      emit(FetchedLocation(updatedLocations));
    } catch (e) {
      emit(AddingLocationFailure(e.toString()));
    }
  }

  Future<void> changingLocation(String id) async {
    selectedId = id;
    try {
      final chosenLocation = await checkoutServices.chosenLocation(id);
      emit(ChosenLocation(chosenLocation));
    } catch (e) {
      emit(ChosingLocationError(e.toString()));
    }
  }

  Future<void> confirmLocation() async {
    emit(ConfirmLocationLoading());
       try {
      var previousLocation = (await checkoutServices.fetchLocations(
        true,
      )).first;
      previousLocation = previousLocation.copyWith(isChosen: false);
      var chosenLocation = await checkoutServices.chosenLocation(selectedId!);
      chosenLocation = chosenLocation.copyWith(isChosen: true);
      await checkoutServices.setLocation(previousLocation);
      await checkoutServices.setLocation(chosenLocation);
      emit(ConfirmLocationLoaded(chosenLocation));
    } catch (e) {
      emit(ConfirmLocationFailure(e.toString()));
    }
      }
   
  
}
