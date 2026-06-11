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

final class CategoriesLoading extends HomeState {}

final class CategoriesLoaded extends HomeState {
  final List<CategoriesModel> categories;
  CategoriesLoaded({required this.categories});
}

final class CategoriesFailed extends HomeState {
  final String errorMessage;
  CategoriesFailed({required this.errorMessage});
}

// States for setting favorite status

final class SetFavoriteLoading extends HomeState {
  final String productId;
  SetFavoriteLoading({required this.productId});
}

final class SetFavoriteSuccess extends HomeState {
  final String productId;
  final bool isFavorite;
  SetFavoriteSuccess({required this.isFavorite,required this.productId});
}

final class SetFavoriteError extends HomeState {
  final String productId;
  final String errorMessage;
  SetFavoriteError(this.errorMessage,{required this.productId});
}
