import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/models/address_item_model.dart';
import 'package:flutter/material.dart';

class AddressItemWidget extends StatelessWidget {
  final AddressItemModel location;
  const AddressItemWidget({super.key, required this.location});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: CachedNetworkImage(
            imageUrl: location.image,
            height: MediaQuery.of(context).size.height * 0.12,
            width: MediaQuery.of(context).size.width * 0.3,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(width: MediaQuery.of(context).size.width * 0.08),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(location.city, style: Theme.of(context).textTheme.titleMedium),
            Text(
              '${location.city},${location.country}',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ],
    );
  }
}
