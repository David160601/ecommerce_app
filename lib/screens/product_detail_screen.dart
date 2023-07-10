import 'package:ecommerce_app/models/product_%20model.dart';
import 'package:ecommerce_app/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:transparent_image/transparent_image.dart';

class ProductDetail extends ConsumerStatefulWidget {
  final Product product;
  const ProductDetail({super.key, required this.product});

  @override
  ConsumerState<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends ConsumerState<ProductDetail> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.title ?? ""),
      ),
      body: Column(children: [
        FadeInImage(
            height: height * 0.4,
            width: double.infinity,
            fit: BoxFit.cover,
            placeholder: MemoryImage(kTransparentImage),
            image: NetworkImage(widget.product.images?.isNotEmpty == true
                ? widget.product.images![0]
                : '')),
        Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "\$ ${widget.product.price.toString()}" ?? '',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  widget.product.description ?? '',
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
            bool added = ref
                .read(cartProvider.notifier)
                .addProductToCart(widget.product);
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
