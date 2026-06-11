import 'package:e_commerce_app/services/favorite_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/models/product_item_model.dart';


part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(FavoriteInitial());
  final favoriteServices = FavoriteServicesImpl();

  Future<void> loadFavoriteProducts() async {
    emit(FavoriteLoading());
    try {
      final favoriteProducts = await favoriteServices.fetchFavoriteProducts();
      emit(FavoriteLoaded(favoriteProducts));
    } catch (e) {
      emit(FavoriteLoadedError(e.toString()));
    }
  }
}
