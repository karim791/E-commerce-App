part of 'cart_cubit.dart';

sealed class CartState {}

final class CartInitial extends CartState {}

final class CartLoading extends CartState {}

final class CartLoaded extends CartState {
  final List<AddToCart> cartItem;
  final double subtotal;

  CartLoaded({required this.cartItem, required this.subtotal});
}

final class CartError extends CartState {
  final String errorMessage;

  CartError({required this.errorMessage});
}

final class CounterLoaded extends CartState {
  final bool onTap;
  final int value;
  final String productId;

  CounterLoaded({
    required this.value,
    required this.productId,
    required this.onTap,
  });
}

final class SubtotalUpdated extends CartState {
  final double subtotal;

  SubtotalUpdated({required this.subtotal});

}
