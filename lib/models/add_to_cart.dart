import 'package:e_commerce_app/models/product_item_model.dart';

class AddToCartModel {
  final String id;
  final ProductItemsModel product;
  final ProductSize size;
  final int quantity;


  const AddToCartModel({
    required this.id,
    required this.product,
    required this.size,
    required this.quantity,
  
  });

  double get totalPrice => product.price*quantity;

  AddToCartModel copyWith({
    String? id,
    ProductItemsModel? product,
    ProductSize? size,
    int? quantity,
    
  }) {
    return AddToCartModel(
      id: id ?? this.id,
      product: product ?? this.product,
      size: size ?? this.size,
      quantity: quantity ?? this.quantity,
      
    );
  }

  

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'product': product.toMap(),
      'size': size.name,
      'quantity': quantity,
      
    };
  }

  factory AddToCartModel.fromMap(Map<String, dynamic> map,String id) {
    return AddToCartModel(
      id: map['id'] as String,
      product: ProductItemsModel.fromMap(map['product'],),
      size: ProductSize.fromString(map['size']),
      quantity: map['quantity'] as int,
    );
  }

}

List<AddToCartModel> dummyCart = [];
