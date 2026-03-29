import 'package:e_commerce_app/views/widget/categories_tab_view.dart';
import 'package:e_commerce_app/views/widget/home_tap_view.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    //final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Row(
            //       children: [
            //         CircleAvatar(
            //           radius: 30,
            //           backgroundImage: AssetImage(
            //             "assets/images/571467967_2221330675054332_5857262115784261188_n.jpg",
            //           ),
            //         ),
            //         SizedBox(width: size.width * 0.03),
            //         Column(
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: [
            //             Text('Kareem Mardy', style: textTheme.labelLarge),
            //             Text(
            //               'Let\'s go shopping!',
            //               style: textTheme.labelMedium!.copyWith(
            //                 color: Colors.grey,
            //               ),
            //             ),
            //           ],
            //         ),
            //       ],
            //     ),
            //     Row(
            //       children: [
            //         IconButton(onPressed: () {}, icon: Icon(Icons.search)),
            //         IconButton(
            //           onPressed: () {},
            //           icon: Icon(Icons.notifications),
            //         ),
            //       ],
            //     ),
            //   ],
            // ),
           // SizedBox(height: size.height * 0.03),
            SizedBox(
              child: TabBar(
                controller: _tabController,
                unselectedLabelColor: Colors.grey,
                tabs: const[
                  Tab(text: 'Home'),
                  Tab(text: 'Categories'),
                ],
              ),
            ),
            SizedBox(height: size.height * 0.01),
        
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: const [HomeTapView(), CategoriesTabView()],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
