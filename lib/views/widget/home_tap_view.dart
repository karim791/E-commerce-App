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
    final textStyle = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    return BlocBuilder<HomeCubit, HomeState>(
      bloc: BlocProvider.of<HomeCubit>(context),
      builder: (context, state) {
        if (state is HomeLoading) {
          return const Center(child: CircularProgressIndicator());
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
                              imageUrl: state
                                  .homeCarouselItems[itemIndex]
                                  .imgUrl,
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) => Center(
                                    child: CircularProgressIndicator.adaptive(
                                      value: downloadProgress.progress,
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
                    return Column(
                      children: [
                        Expanded(
                          child: Stack(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                    AppRoutes.productDetailsPage,
                                    arguments: state.products[index].id,
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Center(
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          state.products[index].imgUrl,
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
                                                ),
                                          ),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: AlignmentGeometry.topRight,
                                child: IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.favorite_border),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          state.products[index].name,
                          style: textStyle.labelLarge!.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 17,
                          ),
                        ),

                        Text(
                          state.products[index].category,
                          style: textStyle.labelMedium!.copyWith(
                            fontWeight: FontWeight.w400,
                            color: Colors.grey,
                          ),
                        ),

                        Text(
                          "\$${state.products[index].price}",
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
