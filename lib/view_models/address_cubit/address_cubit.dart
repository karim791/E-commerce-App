import 'package:e_commerce_app/models/address_item_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'address_state.dart';

class AddressCubit extends Cubit<AddressState> {
  AddressCubit() : super(AddressInitial());

  String? selectedId;

  void fetchAddress() {
    emit(FetchingLocation());
    Future.delayed(Duration(seconds: 1), () {
      final locations = dummyLocations;
      emit(FetchedLocation(locations));
    });
  }

  void addingLocation(String location) {
    emit(AddingLocation());
    Future.delayed(Duration(seconds: 1), () {
      final locations = location.split('-');
      final newLocation = AddressItemModel(
        id: DateTime.now().toIso8601String(),
        city: locations.first,
        country: locations.last,
      );
      dummyLocations.add(newLocation);
      emit(AddedLocation());
      emit(FetchedLocation(dummyLocations));
    });
  }

  void chooseLocation(String id) {
    selectedId = id;
    final location = dummyLocations.firstWhere(
      (location) => location.id == id,
      orElse: () => dummyLocations.first,
    );
    emit(ChosenLocation(location));
  }

  void confirmLocation() {
    emit(ConfirmLocationLoading());
    Future.delayed(Duration(seconds: 1), () {
      var chosenLocation = dummyLocations.firstWhere(
        (location) => location.id == selectedId,
      );
      var previousLocation = dummyLocations.firstWhere(
        (location) => location.isChosen == true,
        orElse: () => dummyLocations.first,
      );

      chosenLocation = chosenLocation.copyWith(isChosen: true);
      previousLocation = previousLocation.copyWith(isChosen: false);

      final previousIndex = dummyLocations.indexWhere(
        (location) => location.id==previousLocation.id,
      );
      final currentIndex = dummyLocations.indexWhere(
        (location) => location.id == chosenLocation.id,
      );
      dummyLocations[previousIndex] = previousLocation;
      dummyLocations[currentIndex] = chosenLocation;
      emit(ConfirmLocationLoaded());
    });
  }
}
