part of 'product_cubit.dart';

sealed class ProductState {}

final class ProductInitial extends ProductState {}

final class ProductLoading extends ProductState {}

final class CounterLoaded extends ProductState {
  final bool onTap;
  final int value;
  CounterLoaded({required this.value, required this.onTap});
}

final class ProductLoaded extends ProductState {
  final ProductItemsModel product;
  final bool isFavorite;

  ProductLoaded({required this.product, required this.isFavorite});
}

final class SizeSelected extends ProductState {
  final ProductSize size;
  SizeSelected({required this.size});
}

final class AddToCartLoading extends ProductState {}

final class AddToCartLoaded extends ProductState {
  final String productId;

  AddToCartLoaded({required this.productId});
}

final class AddToCartError extends ProductState {
  final String errorMessage;
  AddToCartError(this.errorMessage);
}

final class ProductError extends ProductState {
  final String message;

  ProductError(this.message);
}

final class SetFavoriteLoading extends ProductState {
  final String productId;
  SetFavoriteLoading({required this.productId});
}

final class SetFavoriteSuccess extends ProductState {
  final String productId;
  final bool isFavorite;
  SetFavoriteSuccess({required this.isFavorite, required this.productId});
}

final class SetFavoriteError extends ProductState {
  final String productId;
  final String message;
  SetFavoriteError({required this.message, required this.productId});
}
