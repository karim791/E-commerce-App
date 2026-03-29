part of 'home_cubit.dart';

sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeLoaded extends HomeState {
  final List<ProductItemsModel> dummyProducts;
  final List<HomeCarouselItemModel> dummyHomeCarouselItems;
  HomeLoaded({required this.dummyProducts, required this.dummyHomeCarouselItems});
}

final class HomeError extends HomeState {
  final String errorMessage;
  HomeError({required this.errorMessage});
}
