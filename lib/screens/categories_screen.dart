import 'package:ecommerce_app/constant/style.dart';
import 'package:ecommerce_app/models/category_model.dart';
import 'package:ecommerce_app/services/category_service.dart';
import 'package:ecommerce_app/widgets/category_card.dart';
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class CategorieScreen extends StatefulWidget {
  const CategorieScreen({super.key});

  @override
  State<CategorieScreen> createState() => _CategorieScreenState();
}

class _CategorieScreenState extends State<CategorieScreen> {
  List<Category> categories = [];
  Future<List<Category>> getCategories() async {
    return await CategoryService.getCategoryies();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(CONTAINER_PADDING),
        child: FutureBuilder<List<Category>>(
          future: getCategories(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Category>> snapshot) {
            Widget children;
            if (snapshot.connectionState == ConnectionState.waiting) {
              children = GridView.builder(
                  itemCount: 10,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.5,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20),
                  itemBuilder: (context, index) {
                    return SkeletonLine(
                      style: SkeletonLineStyle(
                          height: double.infinity,
                          borderRadius: BorderRadius.circular(16)),
                    );
                  });
            } else if (snapshot.hasError) {
              children = Container();
            } else {
              if (snapshot.data?.isEmpty == true) {
                children = Container();
              } else {
                children = GridView.builder(
                    itemCount: snapshot.data?.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1.5,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20),
                    itemBuilder: (context, index) {
                      final category = snapshot.data?[index];
                      if (category == null) {
                        return Container();
                      } else {
                        return CategoryCard(
                          category: category,
                        );
                      }
                    });
              }
            }
            return children;
          },
        ));
  }
}
