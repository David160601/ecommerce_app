import 'package:ecommerce_app/models/product_%20model.dart';
import 'package:ecommerce_app/screens/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';
import 'package:transparent_image/transparent_image.dart';

class SlideItem extends StatelessWidget {
  final Product product;
  const SlideItem({super.key, required this.product});
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Card(
      color: Colors.pinkAccent,
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProductDetail(product: product)));
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Card(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text(
                      "Big discount",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    Text(
                      "50 %",
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ],
                ),
              )),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: FadeInImage(
                    placeholder: MemoryImage(kTransparentImage),
                    fit: BoxFit.cover,
                    width: double.maxFinite,
                    height: height * 0.75,
                    image: NetworkImage(product.images?.isNotEmpty == true
                        ? product.images![0]
                        : '')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SlideItemSkeleton extends StatelessWidget {
  const SlideItemSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return const SkeletonLine(
      style: SkeletonLineStyle(height: double.infinity),
    );
  }
}
