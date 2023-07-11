import 'package:ecommerce_app/models/product_%20model.dart';
import 'package:ecommerce_app/providers/cart_provider.dart';
import 'package:ecommerce_app/widgets/cart_icon.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:transparent_image/transparent_image.dart';

class ProductDetail extends ConsumerWidget {
  final Product product;
  const ProductDetail({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title ?? ""),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 20, top: 10),
            child: CardIcon(),
          )
        ],
      ),
      body: Column(children: [
        FadeInImage(
            height: height * 0.4,
            width: double.infinity,
            fit: BoxFit.cover,
            placeholder: MemoryImage(kTransparentImage),
            image: NetworkImage(
                product.images?.isNotEmpty == true ? product.images![0] : '')),
        Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "\$ ${product.price.toString()}" ?? '',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  product.description ?? '',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ))
      ]),
      bottomSheet: Container(
        width: double.infinity,
        color: Colors.white,
        padding: const EdgeInsets.all(20),
        child: ElevatedButton(
          onPressed: () {
            bool added =
                ref.read(cartProvider.notifier).addProductToCart(product);
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                  added ? 'Product added to cart' : "Product already added"),
            ));
          },
          style: ElevatedButton.styleFrom(foregroundColor: Colors.pink),
          child: const Text(
            "Add to cart",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
