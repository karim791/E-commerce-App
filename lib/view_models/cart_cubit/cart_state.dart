part of 'cart_cubit.dart';

sealed class CartState {}

final class CartInitial extends CartState {}

final class CartLoading extends CartState {}

final class CartLoaded extends CartState {
  final List<AddToCartModel> cartItem;
  final double subtotal;

  CartLoaded({required this.cartItem, required this.subtotal});
}

final class CartError extends CartState {
  final String errorMessage;

  CartError({required this.errorMessage});
}

final class SubtotalUpdated extends CartState {
  final double subtotal;

  SubtotalUpdated({required this.subtotal});
}


// Counter states

final class CounterLoading extends CartState {
  final String productId;

  CounterLoading({required this.productId});
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

final class CounterError extends CartState {
  final String errorMessage;

  CounterError( this.errorMessage);
}

// Remove from cart states
final class RemoveFromCartLoading extends CartState {
  final String productId;

  RemoveFromCartLoading({required this.productId});
}
final class RemoveFromCartLoaded extends CartState {
  final String productId;

  RemoveFromCartLoaded({required this.productId});
}
final class RemoveFromCartError extends CartState {
  final String errorMessage;
  final String productId;

  RemoveFromCartError( this.errorMessage, {required this.productId});
}
