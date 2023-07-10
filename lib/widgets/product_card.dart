import 'package:ecommerce_app/constant/style.dart';
import 'package:ecommerce_app/models/product_%20model.dart';
import 'package:ecommerce_app/providers/cart_provider.dart';
import 'package:ecommerce_app/screens/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:transparent_image/transparent_image.dart';

class ProductCard extends ConsumerStatefulWidget {
  final Product product;
  const ProductCard({super.key, required this.product});

  @override
  ConsumerState<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends ConsumerState<ProductCard> {
  late SnackBar currentSnackBar;
  void _showSnackBar(BuildContext context, snackBar) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductDetail(product: widget.product)),
          );
        },
        child: Ink(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          "\$ ${widget.product.price ?? ""}",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      IconButton(
                          splashRadius: ICON_SPLASH_RADIUS,
                          onPressed: () {
                            bool added = ref
                                .read(cartProvider.notifier)
                                .addProductToCart(widget.product);
                            _showSnackBar(
                                context,
                                SnackBar(
                                  content: Text(added
                                      ? 'Product added to cart'
                                      : "Product already added"),
                                ));
                          },
                          icon: const Icon(Icons.add))
                    ],
                  ),
                ),
              ),
              Flexible(
                flex: 3,
                child: SizedBox(
                  width: double.maxFinite,
                  child: FadeInImage(
                      fit: BoxFit.cover,
                      height: height * 0.5,
                      placeholder: MemoryImage(kTransparentImage),
                      image: NetworkImage(
                          widget.product.images?.isNotEmpty == true
                              ? widget.product.images![0]
                              : '')),
                ),
              ),
              Flexible(
                  child: Text(
                widget.product.title ?? '',
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodySmall,
              )),
              const SizedBox(height: 3)
            ],
          ),
        ),
      ),
    );
  }
}
