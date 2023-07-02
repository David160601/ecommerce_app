import 'package:ecommerce_app/models/product_%20model.dart';
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';
import 'package:transparent_image/transparent_image.dart';

class SlideItem extends StatelessWidget {
  final Product product;
  const SlideItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      width: double.infinity,
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 240, 163, 189),
          borderRadius: BorderRadius.circular(5)),
      child: Row(
        children: [
          Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Big discount",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  Text(
                    "50 %",
                    style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                  ),
                ],
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
