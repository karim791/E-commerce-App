import 'package:e_commerce_app/utilities/app_routes.dart';
import 'package:e_commerce_app/view_models/address_cubit/address_cubit.dart';
import 'package:e_commerce_app/view_models/auth_cubit/auth_cubit.dart';
import 'package:e_commerce_app/view_models/payment_cubit/payment_method_cubit.dart';
import 'package:e_commerce_app/view_models/checkout_cubit/checkout_cubit.dart';
import 'package:e_commerce_app/view_models/product_cubit/product_cubit.dart';
import 'package:e_commerce_app/views/pages/address_page.dart';
import 'package:e_commerce_app/views/pages/bottom_nav_bar.dart';
import 'package:e_commerce_app/views/pages/checkout_page.dart';
import 'package:e_commerce_app/views/pages/create_account.dart';
import 'package:e_commerce_app/views/pages/favorite_page.dart';
import 'package:e_commerce_app/views/pages/cart_page.dart';
import 'package:e_commerce_app/views/pages/add_new_card.dart';
import 'package:e_commerce_app/views/pages/login_page.dart';
import 'package:e_commerce_app/views/pages/product_details_page.dart';
import 'package:e_commerce_app/views/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {

      case AppRoutes.homePage:
        return MaterialPageRoute(builder: (_) => BottomNavBar());

      case AppRoutes.productDetailsPage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) {
              final cubit = ProductCubit();
              cubit.getProductById(settings.arguments as String);
              return cubit;
            },
            child: ProductDetailsPage(productId: settings.arguments as String),
          ),
        );

      case AppRoutes.cartPage:
        return MaterialPageRoute(builder: (_) => CartPage());
        
      case AppRoutes.loginPage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => AuthCubit(),
            child: LoginPage(),
          ),
        );

      case AppRoutes.createAccountPage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => AuthCubit(),
            child: CreateAccountPage(),
          ),
        );

      case AppRoutes.addressPage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) {
              final cubit = AddressCubit();
              cubit.fetchAddress();
              return cubit;
            },
            child: AddressPage(),
          ),
        );

      case AppRoutes.paymentPage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) {
              final cubit = PaymentMethodCubit();
              return cubit;
            },
            child: AddNewCardPage(),
          ),
        );

      case AppRoutes.profilePage:
        return MaterialPageRoute(builder: (_) => ProfilePage());

      case AppRoutes.checkoutPage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) {
              final cubit = CheckoutCubit();
              cubit.getCheckout();

              return cubit;
            },
            child: CheckoutPage(),
          ),
        );
        
      case AppRoutes.favoritePage:
        return MaterialPageRoute(builder: (_) => FavoritePage());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
