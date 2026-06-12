import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/models/add_to_cart.dart';
import 'package:e_commerce_app/view_models/cart_cubit/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartCastom extends StatelessWidget {
  final AddToCartModel cartItem;

  const CartCastom({super.key, required this.cartItem});

  Widget _counterWidget({
    required BuildContext context,
    required String productId,
    required int counterValue,
    bool? onTap,
    required dynamic cubit,
  }) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.045,
      width: size.width * 0.24,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CircleAvatar(
            radius: 17,
            backgroundColor: onTap != null && onTap == false
                ? Colors.black54
                : Colors.white,
            child: IconButton(
              icon: onTap != null && onTap == false
                  ? Icon(Icons.remove, size: 16, color: Colors.white)
                  : Icon(Icons.remove, size: 16),
              onPressed: () async =>
                  await cubit.decrementCounter(cartItem, counterValue),
            ),
          ),
          Text(
            counterValue.toString(),
            style: Theme.of(
              context,
            ).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
          ),
          CircleAvatar(
            radius: 17,
            backgroundColor: onTap != null && onTap == true
                ? Colors.black54
                : Colors.white,
            child: IconButton(
              icon: onTap != null && onTap == true
                  ? Icon(Icons.add, size: 16, color: Colors.white)
                  : Icon(Icons.add, size: 16),
              onPressed: () async =>
                  await cubit.incrementCounter(cartItem, counterValue),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    final cartCubit = BlocProvider.of<CartCubit>(context);
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [
                        Column(
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
                          ],
                        ),
                        BlocBuilder<CartCubit, CartState>(
                          bloc: cartCubit,
                          buildWhen: (previous, current) => current is RemoveFromCartLoading && current.productId == cartItem.id ||
                              current is RemoveFromCartLoaded && current.productId == cartItem.id ||
                              current is RemoveFromCartError && current.productId == cartItem.id,
                          builder: (context, state) {
                            if(state is RemoveFromCartLoading){
                              return CircularProgressIndicator(color: Colors.red, strokeWidth: 2);
                            }
                             if(state is RemoveFromCartError){
                              return Icon(Icons.error, color: Colors.red);
                            }
                            return IconButton(
                              onPressed: () async => await cartCubit.removeFromCart(cartItem),
                              icon: Icon(Icons.delete, color: Colors.red),
                            );
                          },
                        ),
                      ],
                    ),

                    SizedBox(height: 5),
                    BlocBuilder<CartCubit, CartState>(
                      bloc: cartCubit,
                      buildWhen: (previous, current) =>
                          current is CounterLoaded &&
                          current.productId == cartItem.id,
                      builder: (context, state) {
                        if (state is CounterLoaded) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _counterWidget(
                                context: context,
                                productId: cartItem.id,
                                counterValue: state.value,
                                onTap: state.onTap,
                                cubit: cartCubit,
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
                            _counterWidget(
                              context: context,
                              productId: cartItem.id,
                              counterValue: cartItem.quantity,
                              cubit: cartCubit,
                              onTap: null,
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
