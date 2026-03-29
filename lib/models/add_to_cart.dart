import 'package:e_commerce_app/models/product_item_model.dart';

class AddToCart {
  final String id;
  final ProductItemsModel product;
  final ProductSize size;
  final int quantity;
  final double totalPrice;

  AddToCart({
    required this.id,
    required this.product,
    required this.size,
    required this.quantity,
    required this.totalPrice,
  });

  AddToCart copyWith({
    String? id,
    ProductItemsModel? product,
    ProductSize? size,
    int? quantity,
    double? totalPrice,
  }) {
    return AddToCart(
      id: id ?? this.id,
      product: product ?? this.product,
      size: size ?? this.size,
      quantity: quantity ?? this.quantity,
      totalPrice: totalPrice ?? this.totalPrice,
    );
  }
}

List<AddToCart> dummyCart = [];
