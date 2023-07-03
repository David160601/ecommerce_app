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
    return Container(
      height: 120, // Set the desired height here
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 10.0,
            spreadRadius: 0.0,
            offset: const Offset(
              2.0,
              2.0,
            ),
          )
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Flexible(
                    flex: 2,
                    child: FadeInImage(
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
                  Flexible(
                    flex: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.title ?? "",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
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
          ),
          IconButton(
            onPressed: () {
              ref.read(cartProvider.notifier).removeProductFromCart(product);
            },
            icon: const Icon(Icons.cancel),
          ),
        ],
      ),
    );
  }
}
