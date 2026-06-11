enum ProductSize {
  S,
  M,
  L,
  X;

  static ProductSize fromString(String size) {
    switch (size.toUpperCase()) {
      case 'S':
        return ProductSize.S;
      case 'M':
        return ProductSize.M;
      case 'L':
        return ProductSize.L;
      case 'X':
        return ProductSize.X;
      default:
        throw ArgumentError('Invalid size: $size');
    }
  }
}

class ProductItemsModel {
  final String id;
  final String name;
  final String imgUrl;
  final double price;
  final bool isFav;
  final String category;
  final String description;
  final double averageRate;

  ProductItemsModel({
    required this.id,
    required this.imgUrl,
    required this.name,
    required this.price,
    required this.category,
    this.description =
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
    this.isFav = false,
    this.averageRate = 4.2,
  });

  ProductItemsModel copyWith({
    String? id,
    String? name,
    String? imgUrl,
    double? price,
    bool? isFav,
    String? category,
    String? description,
    double? averageRate,
  }) {
    return ProductItemsModel(
      id: id ?? this.id,
      name: name ?? this.name,
      imgUrl: imgUrl ?? this.imgUrl,
      price: price ?? this.price,
      isFav: isFav ?? this.isFav,
      category: category ?? this.category,
      averageRate: averageRate ?? this.averageRate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'imgUrl': imgUrl,
      'price': price,

      'category': category,
      'averageRate': averageRate,
    };
  }

  factory ProductItemsModel.fromMap(Map<String, dynamic> map) {
    return ProductItemsModel(
      id: map['id'] as String,
      name: map['name'] as String,
      imgUrl: map['imgUrl'] as String,
      price: map['price'] as double,

      category: map['category'] as String,
      averageRate: map['averageRate'] as double,
    );
  }
}

// List<ProductItemsModel> dummyProducts = [
//   ProductItemsModel(
//     id: 'K434118okA3XH70vmCgI',
//     name: 'Black Shoes',
//     imgUrl: 'https://pngimg.com/d/men_shoes_PNG7475.png',
//     price: 20,
//     category: 'Shoes',
//   ),
//   ProductItemsModel(
//     id: '3p6nOiAbCwlKNZkme7t2',
//     name: 'Trousers',
//     imgUrl:
//         'https://www.pngall.com/wp-content/uploads/2016/09/Trouser-Free-Download-PNG.png',
//     price: 30,
//     category: 'Clothes',
//   ),

//   ProductItemsModel(
//     id: 'OHncCKAImAwC9jg9XPam',
//     name: 'Pack of Potatoes',
//     imgUrl: 'https://pngimg.com/d/potato_png2398.png',
//     price: 10,
//     category: 'Groceries',
//   ),
//   ProductItemsModel(
//     id: '7WqSYwiEbed0G05zM72u',
//     name: 'Pack of Onions',
//     imgUrl: 'https://pngimg.com/d/onion_PNG99213.png',
//     price: 10,
//     category: 'Groceries',
//   ),
//   ProductItemsModel(
//     id: 'NQwKrejnxOFcgAzdkoQm',
//     name: 'Pack of Apples',
//     imgUrl: 'https://pngfre.com/wp-content/uploads/apple-43-1024x1015.png',
//     price: 10,
//     category: 'Fruits',
//   ),

//   ProductItemsModel(
//     id: 'BOQKlAc0GlRZXOmzcs1l',
//     name: 'Pack of Bananas',
//     imgUrl:
//         'https://static.vecteezy.com/system/resources/previews/015/100/096/original/bananas-transparent-background-free-png.png',
//     price: 10,
//     category: 'Fruits',
//   ),
//   ProductItemsModel(
//     id: 'atZHZfhF5glVKKO3XCtz',
//     name: 'Pack of Mangoes',
//     imgUrl: 'https://purepng.com/public/uploads/large/mango-tgy.png',
//     price: 10,
//     category: 'Fruits',
//   ),
//   ProductItemsModel(
//     id: 'jXDJxAUnBWJTXrOn5V1n',
//     name: 'Sweet Shirt',
//     imgUrl:
//         'https://www.usherbrand.com/cdn/shop/products/5uYjJeWpde9urtZyWKwFK4GHS6S3thwKRuYaMRph7bBDyqSZwZ_87x1mq24b2e7_1800x1800.png',
//     price: 15,
//     category: 'Clothes',
//   ),
// ];
