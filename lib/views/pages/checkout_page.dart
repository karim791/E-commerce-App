import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/models/address_item_model.dart';
import 'package:e_commerce_app/models/payment_card_model.dart';
import 'package:e_commerce_app/utilities/app_routes.dart';
import 'package:e_commerce_app/view_models/checkout_cubit/checkout_cubit.dart';
import 'package:e_commerce_app/view_models/payment_cubit/payment_method_cubit.dart';
import 'package:e_commerce_app/views/widget/address_item_widget.dart';
import 'package:e_commerce_app/views/widget/empty_address_payment.dart';
import 'package:e_commerce_app/views/widget/checkout_component.dart';
import 'package:e_commerce_app/views/widget/modal_bottom_sheet.dart';
import 'package:e_commerce_app/views/widget/payment_card_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  Widget _buildPaymentCard(BuildContext context, PaymentCardModel? chosenCard) {
    final checkoutCubit = BlocProvider.of<CheckoutCubit>(context);
    if (chosenCard != null) {
      return PaymentCardItem(
        chosenCard: chosenCard,
        onItemTap: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (_) {
              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.6,
                child: BlocProvider(
                  create: (context) {
                    final cubit = PaymentMethodCubit();
                    cubit.fetchPaymentMethod();
                    return cubit;
                  },
                  child: ModalBottomSheetMethod(),
                ),
              );
            },
          ).then((value) async => await checkoutCubit.getCheckout());
        },
      );
    } else {
      return EmptyAddressPayment(title: 'Add Payment Method', isChosen: true);
    }
  }

  Widget _buildAddressWidget(BuildContext context, AddressItemModel? location) {
    if (location != null) {
      return AddressItemWidget(location: location);
    } else {
      return EmptyAddressPayment(
        title: 'Add Shipping Address',
        isChosen: false,
      );
    }
  }

  //  Widget _totalPriceWidget(
  //   BuildContext context,
  //   String totalPrice,
  //   double price,
  // ) {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //     children: [
  //       Text(
  //         totalPrice,
  //         style: Theme.of(context).textTheme.titleLarge!.copyWith(
  //           fontWeight: FontWeight.w500,
  //           color: Colors.grey,
  //         ),
  //       ),
  //       Text(
  //         '\$$price',
  //         style: Theme.of(
  //           context,
  //         ).textTheme.bodyLarge!.copyWith(color: Colors.black),
  //       ),
  //     ],
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    final cubit = BlocProvider.of<CheckoutCubit>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Checkout Page'), centerTitle: true),
      body: BlocBuilder<CheckoutCubit, CheckoutState>(
        bloc: cubit,
        buildWhen: (previous, current) =>
            current is CheckoutLoading ||
            current is CheckoutLoaded ||
            current is CheckoutLoading,
        builder: (context, state) {
          if (state is CheckoutLoading) {
            return Center(
              child: CircularProgressIndicator.adaptive(strokeAlign: 2),
            );
          } else if (state is CheckoutLoaded) {
            return SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      CheckoutComponent(
                        title: 'Address',
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(AppRoutes.addressPage)
                              .then((value) async => await cubit.getCheckout());
                        },
                      ),
                      _buildAddressWidget(context, state.location),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      CheckoutComponent(
                        title: 'Products',
                        amount: state.amount,
                      ),

                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: state.cartItem.length,
                        itemBuilder: (context, index) {
                          final cartItem = state.cartItem[index];
                          return Column(
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                            style: textTheme.bodyLarge!
                                                .copyWith(color: Colors.grey),
                                            children: [
                                              TextSpan(
                                                text: cartItem.size.name,
                                                style: textTheme.bodyMedium!
                                                    .copyWith(
                                                      color: Colors.black,
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Text.rich(
                                          TextSpan(
                                            text: 'Amount: ',
                                            style: textTheme.bodyLarge!
                                                .copyWith(color: Colors.grey),
                                            children: [
                                              TextSpan(
                                                text: cartItem.quantity
                                                    .toString(),
                                                style: textTheme.bodyMedium!
                                                    .copyWith(
                                                      color: Colors.black,
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    '\$${cartItem.product.price * cartItem.quantity}',
                                    style: textTheme.titleLarge!.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Divider(
                                color: Colors.grey[300],
                                height: size.height * 0.02,
                              ),
                            ],
                          );
                        },
                      ),

                      CheckoutComponent(title: 'Payment Methods'),
                      SizedBox(height: size.height * 0.01),
                      _buildPaymentCard(context, state.paymentCard),

                      SizedBox(height: size.height * 0.01),
                      Divider(
                        color: Colors.grey[300],
                        height: size.height * 0.02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total Amount',
                            style: textTheme.bodyLarge!.copyWith(
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            '\$${state.subtotal}',
                            style: textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: size.height * 0.01),
                      SizedBox(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.06,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).primaryColor,
                          ),
                          child: Text(
                            'Proceed To Buy',
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
              ),
            );
          } else if (state is CheckoutError) {
            return Center(child: Text(state.message));
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                CheckoutComponent(title: 'Address', onTap: () {}),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                CheckoutComponent(title: 'Products', amount: 0),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                CheckoutComponent(title: 'Payment Methods'),
              ],
            ),
          );
        },
      ),
    );
  }
}
