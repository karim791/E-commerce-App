class CategoriesModel {
  final String id;
  final String name;
  final String imgUrl;
  final int productCount;

  CategoriesModel({
    required this.id,
    required this.name,
    required this.imgUrl,
    required this.productCount,
  });
}

List<CategoriesModel> dummyCategories = [
  CategoriesModel(
    id: '5',
    name: 'New Arrivals',
    imgUrl: "assets/images/categories/pngegg_5.png",
    productCount: 180,
  ),
  CategoriesModel(
    id: '1',
    name: 'Clothes',
    imgUrl: "assets/images/categories/pngegg_1.png",
    productCount: 102,
  ),
  CategoriesModel(
    id: '2',
    name: 'Bags',
    imgUrl: "assets/images/categories/pngegg_2.png",
    productCount: 42,
  ),
  CategoriesModel(
    id: '3',
    name: 'Shoes',
    imgUrl: "assets/images/categories/pngegg_3.png",
    productCount: 85,
  ),
  CategoriesModel(
    id: '4',
    name: 'Electronics',
    imgUrl: "assets/images/categories/pngegg_4.png",
    productCount: 50,
  ),
];
