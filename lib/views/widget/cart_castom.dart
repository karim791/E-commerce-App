import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/models/add_to_cart.dart';
import 'package:e_commerce_app/view_models/cart_cubit/cart_cubit.dart';
import 'package:e_commerce_app/views/widget/counter_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartCastom extends StatelessWidget {
  final AddToCartModel cartItem;

  const CartCastom({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0),
      child: Column(
        children: [
          Row(
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey[200],
                ),
                child: CachedNetworkImage(
                  imageUrl: cartItem.product.imgUrl,
                  height: size.height * 0.1,
                  width: size.width * 0.3,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(width: size.width * 0.04),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cartItem.product.name,
                      style: textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: size.height * 0.01),
                    Text.rich(
                      TextSpan(
                        text: 'Size: ',
                        style: textTheme.bodyLarge!.copyWith(
                          color: Colors.grey,
                        ),
                        children: [
                          TextSpan(
                            text: cartItem.size.name,
                            style: textTheme.bodyMedium!.copyWith(
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 5),
                    BlocBuilder<CartCubit, CartState>(
                      bloc: BlocProvider.of<CartCubit>(context),
                      buildWhen: (previous, current) =>
                          current is CounterLoaded &&
                          current.productId == cartItem.product.id,
                      builder: (context, state) {
                        if (state is CounterLoaded) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CounterWidget(
                                onTap: state.onTap,
                                counterValue: state.value,
                                cubit: BlocProvider.of<CartCubit>(context),
                                productId: cartItem.product.id,
                              ),

                              Text(
                                '\$${cartItem.product.price * state.value}',
                                style: textTheme.titleLarge!.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          );
                        }
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CounterWidget(
                              onTap: null,
                              initialValue: cartItem.quantity,
                              counterValue: cartItem.quantity,
                              cubit: BlocProvider.of<CartCubit>(context),
                              productId: cartItem.product.id,
                            ),
                            Text(
                              '\$${cartItem.totalPrice}',
                              style: textTheme.titleLarge!.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          Divider(color: Colors.grey[300], height: size.height * 0.02),
        ],
      ),
    );
  }
}
