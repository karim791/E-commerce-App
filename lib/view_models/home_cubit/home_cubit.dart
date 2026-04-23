import 'package:e_commerce_app/models/product_item_model.dart';
import 'package:e_commerce_app/models/home_carousel_item.dart';
import 'package:e_commerce_app/services/home_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  final homeServices = HomeServicesImpl();

  void getHomeData() async {
    emit(HomeLoading());
    try {
      final products = await homeServices.fetchProducts();
      emit(
        HomeLoaded(
          products: products,
          dummyHomeCarouselItems: dummyHomeCarouselItems,
        ),
      );
    } catch (e) {
      emit(HomeError(errorMessage: e.toString()));
    }
  }
}
