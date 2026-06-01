part of 'home_cubit.dart';

sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeLoaded extends HomeState {
  final List<ProductItemsModel> products;
  final List<HomeCarouselItemModel> homeCarouselItems;
  HomeLoaded({required this.products, required this.homeCarouselItems});
}

final class HomeError extends HomeState {
  final String errorMessage;
  HomeError({required this.errorMessage});
}

final class CategoriesLoading extends HomeState {
}

final class CategoriesLoaded extends HomeState {
  final List<CategoriesModel> categories;
  CategoriesLoaded({required this.categories});
}
final class CategoriesFailed extends HomeState {
  final String errorMessage;
  CategoriesFailed({required this.errorMessage});
}
