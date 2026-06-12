import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/view_models/favorite_cubit/favorite_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    final favoriteCubit = BlocProvider.of<FavoriteCubit>(context);
    final size = MediaQuery.sizeOf(context);
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: BlocBuilder<FavoriteCubit, FavoriteState>(
        bloc: favoriteCubit,
        buildWhen: (previous, current) =>
            current is FavoriteLoaded ||
            current is FavoriteLoading ||
            current is FavoriteLoadedError,
        builder: (context, state) {
          if (state is FavoriteLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is FavoriteLoadedError) {
            return Center(child: Text("Error: ${state.errorMessage}"));
          } else if (state is FavoriteLoaded) {
            return state.isEmpty
                ? Center(child: Text("No favorite products found."))
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final product = state.favoriteProducts[index];
                            return Padding(
                              padding: const EdgeInsets.only(
                                left: 16.0,
                                right: 16.0,
                                bottom: 8.0,
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      DecoratedBox(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                          color: Colors.grey[200],
                                        ),
                                        child: CachedNetworkImage(
                                          imageUrl: product.imgUrl,
                                          height: size.height * 0.1,
                                          width: size.width * 0.3,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                      SizedBox(width: size.width * 0.04),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              product.name,
                                              style: textTheme.bodyLarge!
                                                  .copyWith(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            ),
                                            SizedBox(
                                              height: size.height * 0.01,
                                            ),

                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "\$${product.price}",
                                                  style: textTheme.bodyMedium!
                                                      .copyWith(
                                                        color: Colors.green,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                ),
                                                IconButton(
                                                  onPressed: () async {
                                                    await favoriteCubit
                                                        .removeFromFavorite(
                                                          product.id,
                                                        );
                                                  },
                                                  icon: Icon(
                                                    Icons.delete_rounded,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(
                                    color: Colors.grey[300],
                                    height: size.height * 0.02,
                                  ),
                                ],
                              ),
                            );
                          },
                          itemCount: state.favoriteProducts.length,
                        ),
                      ],
                    ),
                  );
          } else {
            return Center(child: Text("No favorite products found."));
          }
        },
      ),
    );
  }
}
