
import 'package:e_commerce_app/utilities/app_routes.dart';
import 'package:e_commerce_app/view_models/cart_cubit/cart_cubit.dart';
import 'package:e_commerce_app/views/widget/cart_castom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dash/flutter_dash.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CartCubit, CartState>(
        bloc: BlocProvider.of<CartCubit>(context),
        buildWhen: (previous, current) =>
            current is CartLoaded ||
            current is CartError ||
            current is CartLoading,
        builder: (context, state) {
          if (state is CartLoaded && state.cartItem.isEmpty) {
            return Center(child: Text('Your Cart is Empty'));
          }
          if (state is CartLoading) {
            return Center(child: CircularProgressIndicator.adaptive());
          } else if (state is CartLoaded) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: state.cartItem.length,
                    itemBuilder: (context, index) {
                      return CartCastom(cartItem: state.cartItem[index]);
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: [
                        BlocBuilder<CartCubit, CartState>(
                          bloc: BlocProvider.of<CartCubit>(context),
                          buildWhen: (previous, current) =>
                              current is SubtotalUpdated,
                          builder: (context, subtotalState) {
                            if (subtotalState is SubtotalUpdated) {
                              return Column(
                                children: [
                                  SizedBox(
                                    height:
                                        MediaQuery.of(context).size.height *
                                        0.02,
                                  ),
                                  totalPriceWidget(
                                    context,
                                    'Subtotal',
                                    subtotalState.subtotal,
                                  ),
                                  SizedBox(
                                    height:
                                        MediaQuery.of(context).size.height *
                                        0.01,
                                  ),
                                  totalPriceWidget(context, 'Discount', 10.0),
                                  SizedBox(
                                    height:
                                        MediaQuery.of(context).size.height *
                                        0.01,
                                  ),
                                  Dash(
                                    direction: Axis.horizontal,
                                    length:
                                        MediaQuery.of(context).size.width -
                                        32.0,
                                    dashLength: 10.0,
                                    dashColor: Colors.grey[300]!,
                                  ),
                                  SizedBox(
                                    height:
                                        MediaQuery.of(context).size.height *
                                        0.01,
                                  ),
                                  totalPriceWidget(
                                    context,
                                    'Total Price',
                                    subtotalState.subtotal - 10,
                                  ),
                                  SizedBox(
                                    height:
                                        MediaQuery.of(context).size.height *
                                        0.02,
                                  ),
                                ],
                              );
                            }

                            return Column(
                              children: [
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.02,
                                ),
                                totalPriceWidget(
                                  context,
                                  'Subtotal',
                                  state.subtotal,
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.01,
                                ),
                                totalPriceWidget(context, 'Discount', 10.0),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.01,
                                ),
                                Dash(
                                  direction: Axis.horizontal,
                                  length:
                                      MediaQuery.of(context).size.width - 32.0,
                                  dashLength: 10.0,
                                  dashColor: Colors.grey[300]!,
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.01,
                                ),
                                totalPriceWidget(
                                  context,
                                  'Total Price',
                                  state.subtotal - 10,
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.02,
                                ),
                              ],
                            );
                          },
                        ),

                        SizedBox(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.06,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(
                                context,
                              ).pushNamed(AppRoutes.checkoutPage);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).primaryColor,
                            ),
                            child: Text(
                              'Checkout',
                              style: Theme.of(context).textTheme.bodyLarge!
                                  .copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else if (state is CartError) {
            return Center(child: Text(state.errorMessage));
          } else {
            return Center(child: Text('Something went wrong'));
          }
        },
      ),
    );
  }

  Widget totalPriceWidget(
    BuildContext context,
    String totalPrice,
    double price,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          totalPrice,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            fontWeight: FontWeight.w500,
            color: Colors.grey,
          ),
        ),
        Text(
          '\$$price',
          style: Theme.of(
            context,
          ).textTheme.bodyLarge!.copyWith(color: Colors.black),
        ),
      ],
    );
  }
}
