class ApiPaths {
  static String users(String userId) => 'users/$userId';
  static String product(String cartItemId) => 'products/$cartItemId';
  static String products() => 'products/';
  static String categories() => 'categories/';
  static String announcement() => 'announcement/';
  static String cartItem(String userId, String productId) =>
      'users/$userId/cart/$productId';
  static String cartItems(String userId) => 'users/$userId/cart/';
  static String favoriteItems(String userId) => 'users/$userId/favorites/';
  static String favoriteItem(String userId, String productId) =>
      'users/$userId/favorites/$productId';
}
