import 'package:flutter/material.dart';

class CounterWidget extends StatelessWidget {
  final int counterValue;
  final dynamic cubit;
  final String productId;
  final int? initialValue;
  final bool? onTap;
  const CounterWidget({
    super.key,
    required this.counterValue,
    required this.cubit,
    required this.productId,
    this.initialValue,
     this.onTap ,
  });

  @override
  Widget build(BuildContext context) {
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
          backgroundColor: onTap != null && onTap==false ? Colors.black54 : Colors.white,
            child: IconButton(
              icon: onTap!=null && onTap==false ? Icon(Icons.remove, size: 16,color: Colors.white,) : Icon(Icons.remove, size: 16),
              onPressed: () =>initialValue != null ? cubit.decrementCounter(productId, initialValue) : cubit.decrementCounter(productId),
              
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
            backgroundColor: onTap!=null && onTap==true ? Colors.black54 : Colors.white,
            child: IconButton(
              icon: onTap!=null && onTap==true ? Icon(Icons.add, size: 16,color: Colors.white,) : Icon(Icons.add, size: 16),
              onPressed: () =>initialValue != null ? cubit.incrementCounter(productId, initialValue) : cubit.incrementCounter(productId),
              
            ),
          ),
        ],
      ),
    );
  }
}
