import 'package:ecommerce_app/models/category_model.dart';
import 'package:ecommerce_app/screens/category_screen.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final Category category;
  const CategoryCard({super.key, required this.category});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CategoryScreen(
                    category: category,
                  )),
        );
      },
      child: Ink(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(category.image ?? ''),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.pink.withOpacity(0.2),
                  BlendMode.srcOver,
                )),
            borderRadius: BorderRadius.circular(16)),
        child: Center(
          child: Text(
            category.name ?? "",
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.merge(const TextStyle(color: Colors.white)),
          ),
        ),
      ),
    );
  }
}
