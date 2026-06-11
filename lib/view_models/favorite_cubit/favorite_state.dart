part of 'favorite_cubit.dart';


sealed class FavoriteState {}

final class FavoriteInitial extends FavoriteState {}


final class FavoriteLoading extends FavoriteState {}


final class FavoriteLoaded extends FavoriteState {
  final List<ProductItemsModel> favoriteProducts;
  FavoriteLoaded(this.favoriteProducts);
}


final class FavoriteLoadedError extends FavoriteState {
  final String errorMessage;
  FavoriteLoadedError(this.errorMessage);
}
