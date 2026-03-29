import 'package:e_commerce_app/utilities/app_routes.dart';
import 'package:e_commerce_app/view_models/checkout_cubit/checkout_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmptyAddressPayment extends StatelessWidget {
  final String title;
  final bool isChosen;
  const EmptyAddressPayment({
    super.key,
    required this.title,
    required this.isChosen,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<CheckoutCubit>(context);
    return InkWell(
      onTap: () {
        if (isChosen == true) {
          Navigator.of(context)
              .pushNamed(AppRoutes.paymentPage)
              .then((value) => cubit.getCheckout());
        } else if (isChosen == false) {
          Navigator.of(context)
              .pushNamed(AppRoutes.addressPage)
              .then((value) => cubit.getCheckout());
        }
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.grey,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Icon(Icons.add, size: MediaQuery.of(context).size.height * 0.03),
              Text(title, style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
        ),
      ),
    );
  }
}
