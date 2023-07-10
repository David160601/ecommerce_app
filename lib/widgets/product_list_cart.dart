import 'package:ecommerce_app/constant/style.dart';
import 'package:ecommerce_app/models/product_%20model.dart';
import 'package:ecommerce_app/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:transparent_image/transparent_image.dart';

class ProductListCartCard extends ConsumerWidget {
  final Product product;
  const ProductListCartCard({Key? key, required this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Material(
      color: Colors.white,
      child: Container(
        height: 100, // Set the desired height here
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: FadeInImage(
                      width: 100,
                      fit: BoxFit.cover, // Fill the entire space
                      placeholder: MemoryImage(kTransparentImage),
                      image: NetworkImage(
                        product.images?.isNotEmpty == true
                            ? product.images![0]
                            : '',
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          product.title ?? "",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              overflow: TextOverflow.ellipsis),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          product.description ?? "",
                          maxLines: 3,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 9,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            IconButton(
              splashRadius: ICON_SPLASH_RADIUS,
              onPressed: () {
                ref.read(cartProvider.notifier).removeProductFromCart(product);
              },
              icon: const Icon(Icons.cancel),
            ),
          ],
        ),
      ),
    );
  }
}
