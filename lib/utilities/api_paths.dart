class ApiPaths {
  static String users(String userId) => 'users/$userId';
  static String product(String cartItemId) => 'products/$cartItemId';
  static String products() => 'products/';
  static String cartItem(String userId, String productId) =>
      'users/$userId/cart/$productId';
  static String cartItems() => 'users/cart/';
}
