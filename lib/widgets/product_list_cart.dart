import 'package:ecommerce_app/models/product_%20model.dart';
import 'package:ecommerce_app/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:transparent_image/transparent_image.dart';

class ProductListCartCard extends ConsumerWidget {
  final Product product;
  const ProductListCartCard({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.3),
          blurRadius: 10.0, // soften the shadow
          spreadRadius: 0.0, //extend the shadow
          offset: const Offset(
            2.0, // Move to right 10  horizontally
            2.0, // Move to bottom 10 Vertically
          ),
        )
      ], color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FadeInImage(
                    fit: BoxFit.cover,
                    height: 100,
                    placeholder: MemoryImage(kTransparentImage),
                    image: NetworkImage(product.images?.isNotEmpty == true
                        ? product.images![0]
                        : '')),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.title ?? "",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        product.description ?? "",
                        maxLines: 3,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 9),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          IconButton(
              onPressed: () {
                ref.read(cartProvider.notifier).removeProductFromCart(product);
              },
              icon: const Icon(Icons.cancel))
        ],
      ),
    );
  }
}
