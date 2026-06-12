import 'package:e_commerce_app/services/favorite_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/models/product_item_model.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(FavoriteInitial());
  final favoriteServices = FavoriteServicesImpl();

  Future<void> getFavoriteProducts() async {
    emit(FavoriteLoading());
    try {
      final List<ProductItemsModel> favoriteProducts = await favoriteServices.fetchFavoriteProducts();
      final bool isEmpty = favoriteProducts.isEmpty;
      emit(FavoriteLoaded(favoriteProducts, isEmpty));
    } catch (e) {
      emit(FavoriteLoadedError(e.toString()));
    }
  }

  Future<void> removeFromFavorite(String productId) async {
    try {
      final List<ProductItemsModel> favoriteProducts = await favoriteServices.fetchFavoriteProducts();
      final product=favoriteProducts.firstWhere((product) => product.id == productId);
      await favoriteServices.removeFromFavorites(product);
      getFavoriteProducts(); // Refresh the favorite products list after removal
    } catch (e) {
      emit(FavoriteLoadedError(e.toString()));
    }
  }
}
