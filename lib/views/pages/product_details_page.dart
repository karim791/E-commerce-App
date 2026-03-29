import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/models/product_item_model.dart';
import 'package:e_commerce_app/view_models/product_cubit/product_cubit.dart';
import 'package:e_commerce_app/views/widget/counter_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsPage extends StatelessWidget {
  final String productId;
  const ProductDetailsPage({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocBuilder<ProductCubit, ProductState>(
      bloc: BlocProvider.of<ProductCubit>(context),
      buildWhen: (previous, current) =>
          current is ProductLoading ||
          current is ProductLoaded ||
          current is ProductError,

      builder: (context, state) {
        if (state is ProductLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator.adaptive()),
          );
        } else if (state is ProductLoaded) {
          final product = state.product;
          return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              title: const Text('Product Details'),
              backgroundColor: Colors.transparent,
              centerTitle: true,
              elevation: 0,
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.favorite_border),
                ),
              ],
            ),
            body: Stack(
              children: [
                Container(
                  color: Colors.grey.shade300,
                  height: size.height * 0.56,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: size.height * 0.06),
                          CachedNetworkImage(
                            imageUrl: state.product.imgUrl,
                            fit: BoxFit.contain,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 470.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                state.product.itemName,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              BlocBuilder<ProductCubit, ProductState>(
                                bloc: BlocProvider.of<ProductCubit>(context),
                                buildWhen: (previous, current) =>
                                    current is CounterLoaded ||
                                    current is ProductLoaded,
                                builder: (context, state) {
                                  if (state is CounterLoaded) {
                                    return CounterWidget(
                                      cubit: BlocProvider.of<ProductCubit>(
                                        context,
                                      ),
                                      productId: productId,
                                      counterValue: state.value,
                                      onTap: state.onTap,
                                    );
                                  } else if (state is ProductLoaded) {
                                    return CounterWidget(
                                      cubit: BlocProvider.of<ProductCubit>(
                                        context,
                                      ),
                                      productId: state.product.id,
                                      counterValue: 1,
                                      onTap:null ,
                                    );
                                  } else {
                                    return const SizedBox.shrink();
                                  }
                                },
                              ),
                            ],
                          ),

                          SizedBox(height: size.height * 0.001),
                          Row(
                            children: [
                              Icon(Icons.star, color: Colors.amber, size: 20),
                              SizedBox(width: 5),
                              Text(
                                '4.5',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              SizedBox(width: 10),
                              Text(
                                '(200 reviews)',
                                style: Theme.of(context).textTheme.bodyMedium!
                                    .copyWith(color: Colors.grey.shade600),
                              ),
                            ],
                          ),
                          SizedBox(height: size.height * 0.01),
                          Text(
                            'Size',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          BlocBuilder<ProductCubit, ProductState>(
                            bloc: BlocProvider.of<ProductCubit>(context),
                            buildWhen: (previous, current) =>
                                current is SizeSelected ||
                                current is ProductLoaded,
                            builder: (context, state) {
                              return Row(
                                children: ProductSize.values.map((size) {
                                  return InkWell(
                                    onTap: () {
                                      BlocProvider.of<ProductCubit>(
                                        context,
                                      ).selectSize(size);
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(right: 8.0),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 8,
                                      ),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(8),
                                        color:
                                            state is SizeSelected &&
                                                state.size == size
                                            ? Theme.of(context).primaryColor
                                            : Colors.transparent,
                                      ),
                                      child: Text(
                                        size.name,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                              color:
                                                  state is SizeSelected &&
                                                      state.size == size
                                                  ? Colors.white
                                                  : Colors.black,
                                            ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              );
                            },
                          ),
                          SizedBox(height: size.height * 0.01),
                          Text(
                            'Description',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text(
                            state.product.description,
                            style: Theme.of(context).textTheme.bodyLarge!
                                .copyWith(color: Colors.black45),
                          ),

                          Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text.rich(
                                TextSpan(
                                  text: '\$ ',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: '${state.product.price}',
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              BlocBuilder<ProductCubit, ProductState>(
                                bloc: BlocProvider.of<ProductCubit>(context),
                                buildWhen: (previous, current) =>
                                    current is AddToCartLoading ||
                                    current is AddToCartLoaded,
                                builder: (context, state) {
                                  if (state is AddToCartLoading) {
                                   return ElevatedButton(
                                      onPressed: null,

                                      child:
                                          const CircularProgressIndicator.adaptive(),
                                    );
                                  } else if (state is AddToCartLoaded) {
                                    return ElevatedButton(
                                      onPressed: null,

                                      child: const Text('Added To Cart'),
                                    );
                                  }
                                  return ElevatedButton.icon(
                                    onPressed: () {
                                      if (BlocProvider.of<ProductCubit>(
                                            context,
                                          ).selectedSize ==
                                          null) {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                              'Please select a size',
                                            ),
                                          ),
                                        );
                                      }else{
                                      BlocProvider.of<ProductCubit>(
                                        context,
                                      ).addToCart(product.id);
                                      }
                                    },
                                    icon: Icon(
                                      Icons.shopping_bag_outlined,
                                      size:
                                          MediaQuery.of(context).size.width *
                                          0.05,
                                    ),
                                    label: Text(
                                      'Add to Cart',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(color: Colors.white),
                                    ),

                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.white,
                                      backgroundColor: Theme.of(
                                        context,
                                      ).primaryColor,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else if (state is ProductError) {
          return Scaffold(body: Center(child: Text(state.message)));
        } else {
          return const Scaffold(body: SizedBox());
        }
      },
    );
  }
}
