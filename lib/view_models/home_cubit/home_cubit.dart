import 'package:e_commerce_app/models/categories_model.dart';
import 'package:e_commerce_app/models/product_item_model.dart';
import 'package:e_commerce_app/models/home_carousel_item.dart';
import 'package:e_commerce_app/services/home_services.dart';
import 'package:e_commerce_app/services/product_details_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  final homeServices = HomeServicesImpl();
  final productDetialsServices = ProductDetailsServicesImpl();

  Future<void> getHomeData() async {
    emit(HomeLoading());
    try {
      final products = await homeServices.fetchProducts();
      final homeCarouselItems = await homeServices.fetchFeaturedProducts();
      
      emit(
        HomeLoaded(
          products: products,
          homeCarouselItems: homeCarouselItems,
          
        ),
      );
    } catch (e) {
      emit(HomeError(errorMessage: e.toString()));
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
