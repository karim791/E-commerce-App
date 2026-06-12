import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/utilities/app_routes.dart';
import 'package:e_commerce_app/view_models/home_cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';

class HomeTapView extends StatelessWidget {
  const HomeTapView({super.key});

  @override
  Widget build(BuildContext context) {
    final homeCubit = BlocProvider.of<HomeCubit>(context);
    final textStyle = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    return BlocBuilder<HomeCubit, HomeState>(
      bloc: homeCubit,
      buildWhen: (previous, current) =>
          current is HomeLoading ||
          current is HomeLoaded ||
          current is HomeError,
      builder: (context, state) {
        if (state is HomeLoading) {
          return const Center(child: CircularProgressIndicator(strokeWidth: 2,));
        } else if (state is HomeLoaded) {
          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: size.height * 0.03),

                SizedBox(
                  height: size.height * 0.21,
                  child: FlutterCarousel.builder(
                    itemCount: state.homeCarouselItems.length,
                    itemBuilder:
                        (
                          BuildContext context,
                          int itemIndex,
                          int pageViewIndex,
                        ) => Padding(
                          padding: const EdgeInsetsDirectional.only(end: 15),
                          child: Card(
                            clipBehavior: Clip.hardEdge,
                            child: CachedNetworkImage(
                              imageUrl:
                                  state.homeCarouselItems[itemIndex].imgUrl,
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) => Center(
                                    child: CircularProgressIndicator.adaptive(
                                      value: downloadProgress.progress,
                                      strokeWidth: 2,
                                    ),
                                  ),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                              width: size.width * 0.8,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                    options: FlutterCarouselOptions(
                      autoPlay: true,
                      height: size.height * 0.21,
                      enableInfiniteScroll: true,
                      slideIndicator: CircularSlideIndicator(),
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('New Arrival', style: textStyle.headlineLarge),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'See All',
                        style: textStyle.labelLarge!.copyWith(
                          color: Colors.deepPurpleAccent,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.01),

                GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                  ),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final product = state.products[index];
                    return Column(
                      children: [
                        Expanded(
                          child: Stack(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                    AppRoutes.productDetailsPage,
                                    arguments: product.id,
                                  ).then((value) => homeCubit.getHomeData(),);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Center(
                                    child: CachedNetworkImage(
                                      imageUrl: product.imgUrl,
                                      progressIndicatorBuilder:
                                          (
                                            context,
                                            url,
                                            downloadProgress,
                                          ) => Center(
                                            child:
                                                CircularProgressIndicator.adaptive(
                                                  value:
                                                      downloadProgress.progress,
                                                      strokeWidth: 2,
                                                ),
                                          ),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 8,
                                right: 8,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: Colors.white54,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: BlocBuilder<HomeCubit, HomeState>(
                                      bloc: homeCubit,
                                      buildWhen: (previous, current) =>
                                          (current is SetFavoriteLoading &&
                                              current.productId ==
                                                  product.id) ||
                                          (current is SetFavoriteSuccess &&
                                              current.productId ==
                                                  product.id) ||
                                          (current is SetFavoriteError &&
                                              current.productId == product.id),
                                      builder: (context, state) {
                                        if (state is SetFavoriteLoading) {
                                          return CircularProgressIndicator.adaptive(strokeWidth: 2,);
                                        } else if (state
                                            is SetFavoriteSuccess) {
                                          return state.isFavorite
                                              ? InkWell(
                                                  onTap: () async {
                                                    await homeCubit.setFavorite(
                                                      product,
                                                    );
                                                  },
                                                  child: const Icon(
                                                    Icons.favorite,
                                                    color: Colors.red,
                                                  ),
                                                )
                                              : InkWell(
                                                  onTap: () async {
                                                    await homeCubit.setFavorite(
                                                      product,
                                                    );
                                                  },
                                                  child: const Icon(
                                                    Icons.favorite_border,
                                                  ),
                                                );
                                        }
                                        return InkWell(
                                          onTap: () async {
                                            await homeCubit.setFavorite(
                                              product,
                                            );
                                          },
                                          child: product.isFav? Icon(
                                            Icons.favorite,
                                            color: Colors.red,
                                          ): Icon(
                                            Icons.favorite_border,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          product.name,
                          style: textStyle.labelLarge!.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 17,
                          ),
                        ),

                        Text(
                          product.category,
                          style: textStyle.labelMedium!.copyWith(
                            fontWeight: FontWeight.w400,
                            color: Colors.grey,
                          ),
                        ),

                        Text(
                          "\$${product.price}",
                          style: textStyle.labelLarge!.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    );
                  },
                  itemCount: state.products.length,
                ),
              ],
            ),
          );
        } else if (state is HomeError) {
          return Center(child: Text(state.errorMessage));
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
