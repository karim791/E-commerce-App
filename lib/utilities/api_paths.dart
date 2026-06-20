class ApiPaths {
  static String users(String userId) => 'users/$userId';
  static String product(String cartItemId) => 'products/$cartItemId';
  static String products() => 'products/';
  static String categories() => 'categories/';
  static String announcement() => 'announcement/';
  static String cartItem(String userId, String productId) =>
      'users/$userId/cart/$productId';
  static String cartItems(String userId) => 'users/$userId/cart/';
  static String paymentCards(String userId) => 'users/$userId/payment-cards/';
  static String paymentCard(String userId, String paymentCardId) => 'users/$userId/payment-cards/$paymentCardId';
  static String locations(String userId) => 'users/$userId/locations/';
  static String location(String userId, String locationId) => 'users/$userId/locations/$locationId';
  static String favoriteItems(String userId) => 'users/$userId/favorites/';
  static String favoriteItem(String userId, String productId) =>
      'users/$userId/favorites/$productId';
}
