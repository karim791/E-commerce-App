import 'package:e_commerce_app/models/categories_model.dart';
import 'package:flutter/material.dart';

class CategoriesTabView extends StatelessWidget {
  const CategoriesTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {},
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      dummyCategories[index].name,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${dummyCategories[index].productCount} products',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      itemCount: dummyCategories.length,
    );
  }
}
