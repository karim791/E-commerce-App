import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/models/payment_card_model.dart';
import 'package:flutter/material.dart';

class PaymentCardItem extends StatelessWidget {
  final VoidCallback onItemTap;
  final PaymentCardModel chosenCard;

  const PaymentCardItem({
    super.key,
    required this.chosenCard,
    required this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onItemTap,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: ListTile(
          leading: CachedNetworkImage(
            imageUrl:
                'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b7/MasterCard_Logo.svg/1200px-MasterCard_Logo.svg.png',
            width: 50,
            height: 50,
            fit: BoxFit.contain,
          ),
          title: Text(chosenCard.holderName),
          subtitle: Text(chosenCard.cardNumber),
          trailing: const Icon(Icons.chevron_right),
        ),
      ),
    );
  }
}
