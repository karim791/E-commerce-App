import 'package:flutter/material.dart';

class CheckoutComponent extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final int? amount;
  final double? subtotalPrice;

  const CheckoutComponent({
    super.key,
    required this.title,
    this.onTap,
    this.amount,
    this.subtotalPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(title, style: Theme.of(context).textTheme.headlineSmall),
            if (amount != null) ...{
              SizedBox(width: MediaQuery.of(context).size.width * 0.02),
              Text('($amount)', style: Theme.of(context).textTheme.bodyLarge),
            },
          ],
        ),
        if (onTap != null)
          TextButton(
            onPressed: onTap,
            child: Text(
              'Edit',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
      ],
    );
  }
}
