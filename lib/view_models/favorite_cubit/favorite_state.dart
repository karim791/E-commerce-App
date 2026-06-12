part of 'favorite_cubit.dart';


sealed class FavoriteState {}

final class FavoriteInitial extends FavoriteState {}


final class FavoriteLoading extends FavoriteState {}


final class FavoriteLoaded extends FavoriteState {
  final List<ProductItemsModel> favoriteProducts;
  final bool isEmpty;
  FavoriteLoaded(this.favoriteProducts, this.isEmpty);
}


final class FavoriteLoadedError extends FavoriteState {
  final String errorMessage;
  FavoriteLoadedError(this.errorMessage);
}
