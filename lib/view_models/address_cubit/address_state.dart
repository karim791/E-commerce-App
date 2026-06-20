part of 'address_cubit.dart';

sealed class AddressState {}

final class AddressInitial extends AddressState {}

final class FetchingLocation extends AddressState {}

final class FetchedLocation extends AddressState {
  final List<AddressItemModel> locations;

  FetchedLocation(this.locations);
}

final class FetchingLocationFailure extends AddressState {
  final String errorMessage;

  FetchingLocationFailure(this.errorMessage);
}

//Add Location states

final class AddingLocation extends AddressState {}

final class AddedLocation extends AddressState {}

final class AddingLocationFailure extends AddressState {
  final String errorMessage;

  AddingLocationFailure(this.errorMessage);
}

// chose Location states

final class ChosingLocation extends AddressState {}

final class ChosenLocation extends AddressState {
  final AddressItemModel? location;

  ChosenLocation(this.location);
}

final class ChosingLocationError extends AddressState {
  final String message;
  ChosingLocationError(this.message);
}

//confirm states

final class ConfirmLocationLoading extends AddressState {}

final class ConfirmLocationLoaded extends AddressState {
  final AddressItemModel chosenLocation;
  ConfirmLocationLoaded(this.chosenLocation);
}

final class ConfirmLocationFailure extends AddressState {
  final String errorMessage;

  ConfirmLocationFailure(this.errorMessage);
}
