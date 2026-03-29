
// ignore: constant_identifier_names
enum ProductSize { S, M, L, XL }

class ProductItemsModel {
  final String imgUrl;
  final String itemName;
  final String brandName;
  final double price;
  final double discountValue;
  final String id;
  final bool isFav;
  final String category;

  final String description =
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.";

  ProductItemsModel({
    required this.id,
    required this.imgUrl,
    required this.itemName,
    required this.brandName,
    required this.price,
    required this.discountValue,
    required this.category,
    this.isFav = false,
    

  });

  ProductItemsModel copyWith({
    String? id,
    String? category,
    String? imgUrl,
    String? itemName,
    String? brandName,
    double? price,
    double? discountValue,
    bool? isFav,
    
  }) {
    return ProductItemsModel(
      category: category ?? this.category,
      id: id ?? this.id,
      imgUrl: imgUrl ?? this.imgUrl,
      itemName: itemName ?? this.itemName,
      brandName: brandName ?? this.brandName,
      price: price ?? this.price,
      discountValue: discountValue ?? this.discountValue,
      isFav: isFav ?? this.isFav,
     
    );
  }
}

List<ProductItemsModel> dummyProducts = [
  ProductItemsModel(
    id: 'K434118okA3XH70vmCgI',
    itemName: 'Black Shoes',
    imgUrl: 'https://pngimg.com/d/men_shoes_PNG7475.png',
    price: 20,
    category: 'Shoes',
    brandName: '',
    discountValue: 20,
  ),
  ProductItemsModel(
    id: '3p6nOiAbCwlKNZkme7t2',
    itemName: 'Trousers',
    imgUrl:
        'https://www.pngall.com/wp-content/uploads/2016/09/Trouser-Free-Download-PNG.png',
    price: 30,
    category: 'Clothes',
    brandName: '',
    discountValue: 20,
  ),

  ProductItemsModel(
    id: 'OHncCKAImAwC9jg9XPam',
    itemName: 'Pack of Potatoes',
    imgUrl: 'https://pngimg.com/d/potato_png2398.png',
    price: 10,
    category: 'Groceries',
    brandName: '',
    discountValue: 20,
  ),
  ProductItemsModel(
    id: '7WqSYwiEbed0G05zM72u',
    itemName: 'Pack of Onions',
    imgUrl: 'https://pngimg.com/d/onion_PNG99213.png',
    price: 10,
    category: 'Groceries',
    brandName: '',
    discountValue: 20,
  ),
  ProductItemsModel(
    id: 'NQwKrejnxOFcgAzdkoQm',
    itemName: 'Pack of Apples',
    imgUrl: 'https://pngfre.com/wp-content/uploads/apple-43-1024x1015.png',
    price: 10,
    category: 'Fruits',
    brandName: '',
    discountValue: 20,
  ),

  ProductItemsModel(
    id: 'BOQKlAc0GlRZXOmzcs1l',
    itemName: 'Pack of Bananas',
    imgUrl:
        'https://static.vecteezy.com/system/resources/previews/015/100/096/original/bananas-transparent-background-free-png.png',
    price: 10,
    category: 'Fruits',
    brandName: '',
    discountValue: 20,
  ),
  ProductItemsModel(
    id: 'atZHZfhF5glVKKO3XCtz',
    itemName: 'Pack of Mangoes',
    imgUrl: 'https://purepng.com/public/uploads/large/mango-tgy.png',
    price: 10,
    category: 'Fruits',
    brandName: '',
    discountValue: 20,
  ),
  ProductItemsModel(
    id: 'jXDJxAUnBWJTXrOn5V1n',
    itemName: 'Sweet Shirt',
    imgUrl:
        'https://www.usherbrand.com/cdn/shop/products/5uYjJeWpde9urtZyWKwFK4GHS6S3thwKRuYaMRph7bBDyqSZwZ_87x1mq24b2e7_1800x1800.png',
    price: 15,
    category: 'Clothes',
    brandName: '',
    discountValue: 20,
  ),
];
