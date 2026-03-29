import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class OtherLoginMethods extends StatelessWidget {
  final String imgUrl;
  final String title;
  final VoidCallback onTap;
  const OtherLoginMethods({
    super.key,
    required this.imgUrl,
    required this.title, required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade200),
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CachedNetworkImage(
                imageUrl: imgUrl,
                fit: BoxFit.contain,
                width: 50,
                height: 50,
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.02),
              Text(title, style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
        ),
      ),
    );
  }
}
