import 'package:e_commerce_app/models/categories_model.dart';
import 'package:e_commerce_app/models/product_item_model.dart';
import 'package:e_commerce_app/models/home_carousel_item.dart';
import 'package:e_commerce_app/services/favorite_services.dart';
import 'package:e_commerce_app/services/home_services.dart';
import 'package:e_commerce_app/services/product_details_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  final homeServices = HomeServicesImpl();
  final productDetialsServices = ProductDetailsServicesImpl();
  final favoriteServices = FavoriteServicesImpl();

  Future<void> getHomeData() async {
    emit(HomeLoading());
    try {
      final products = await homeServices.fetchProducts();
      final favoriteProducts = await favoriteServices.fetchFavoriteProducts();
      final List<ProductItemsModel> editedProducts = products.map((product) {
        final isFavorite = favoriteProducts.any(
          (item) => item.id == product.id,
        );
        return product.copyWith(isFav: isFavorite);
      }).toList();
      final homeCarouselItems = await homeServices.fetchFeaturedProducts();

      emit(
        HomeLoaded(products: editedProducts, homeCarouselItems: homeCarouselItems),
      );
    } catch (e) {
      emit(HomeError(errorMessage: e.toString()));
    }
  }

  Future<void> setFavorite(ProductItemsModel product) async {
    emit(SetFavoriteLoading(productId: product.id));
    try {
      final favoriteProducts = await favoriteServices.fetchFavoriteProducts();
      final isFavorite = favoriteProducts.any((item) => item.id == product.id);
      if (isFavorite) {
        await favoriteServices.removeFromFavorites(product);
      } else {
        await favoriteServices.addToFavorites(product);
      }
      emit(SetFavoriteSuccess(isFavorite: !isFavorite, productId: product.id));
    } catch (e) {
      emit(SetFavoriteError(e.toString(), productId: product.id));
    }
  }

  Future<void> getCategories() async {
    emit(CategoriesLoading());
    try {
      final categories = await homeServices.fetchCategories();
      emit(CategoriesLoaded(categories: categories));
    } catch (e) {
      emit(CategoriesFailed(errorMessage: e.toString()));
    }
  }
}
