import 'package:e_commerce_app/view_models/cart_cubit/cart_cubit.dart';
import 'package:e_commerce_app/view_models/favorite_cubit/favorite_cubit.dart';
import 'package:e_commerce_app/view_models/home_cubit/home_cubit.dart';
import 'package:e_commerce_app/views/pages/favorite_page.dart';
import 'package:e_commerce_app/views/pages/home_page.dart';
import 'package:e_commerce_app/views/pages/cart_page.dart';
import 'package:e_commerce_app/views/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  late int _selected;
  @override
  void initState() {
    super.initState();
    _selected = 0;
  }

  final List<Widget> buildScreens = [
    BlocProvider(
      create: (context) {
        final cubit = HomeCubit();
        cubit.getHomeData();
        cubit.getCategories();
        return cubit;
      },
      child: HomePage(),
    ),
    BlocProvider(
      create: (context) {
        final cubit = CartCubit();
        cubit.getCartData();
        return cubit;
      },
      child: CartPage(),
    ),
    BlocProvider(
      create: (context) {
        final cubit = FavoriteCubit();
        cubit.getFavoriteProducts();
        return cubit;
      },
      child: FavoritePage(),
    ),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    // return PersistentTabView(
    //   controller: _controller,

    //   tabs: [
    //     PersistentTabConfig(
    //       screen: HomePage(),
    //       item: ItemConfig(icon: Icon(Icons.home), title: "Home"),
    //     ),
    //     PersistentTabConfig(
    //       screen: OrderPage(),
    //       item: ItemConfig(
    //         icon: Icon(Icons.shopping_bag_outlined),
    //         title: "Orders",
    //       ),
    //     ),
    //     PersistentTabConfig(
    //       screen: FavoritePage(),
    //       item: ItemConfig(
    //         icon: Icon(Icons.favorite_border_outlined),
    //         title: "Favorites",
    //       ),
    //     ),
    //     PersistentTabConfig(
    //       screen: ProfilePage(),
    //       item: ItemConfig(icon: Icon(Icons.person_outline), title: "Profile"),
    //     ),
    //   ],
    //   navBarBuilder: (navBarConfig) =>
    //       Style1BottomNavBar(navBarConfig: navBarConfig),
    // );

    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.all(4.0),
          child: CircleAvatar(
            backgroundImage: AssetImage(
              "assets/images/571467967_2221330675054332_5857262115784261188_n.jpg",
            ),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Kareem Mardy', style: Theme.of(context).textTheme.labelLarge),
            Text(
              'Let\'s go shopping!',
              style: Theme.of(
                context,
              ).textTheme.labelSmall!.copyWith(color: Colors.grey),
            ),
          ],
        ),
        actions: [
          if (_selected == 0) ...[
            IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.notifications)),
          ] else if (_selected == 1)
            IconButton(onPressed: () {}, icon: const Icon(Icons.shopping_bag)),
        ],
      ),

      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border_outlined),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outlined),
            label: 'Profile',
          ),
        ],
        selectedItemColor: Colors.deepPurpleAccent,
        unselectedItemColor: Colors.grey[400],
        selectedIconTheme: IconThemeData(size: 25),
        currentIndex: _selected,
        onTap: (value) => setState(() {
          _selected = value;
        }),
      ),
      body: SafeArea(child: buildScreens[_selected]),
    );
  }
}
