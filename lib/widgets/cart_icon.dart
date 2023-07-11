import 'package:ecommerce_app/constant/style.dart';
import 'package:ecommerce_app/providers/cart_provider.dart';
import 'package:ecommerce_app/screens/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CardIcon extends ConsumerWidget {
  const CardIcon({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int productSize = ref.watch(cartProvider).length;
    return Badge(
      label: Text(productSize.toString()),
      child: IconButton(
          splashRadius: ICON_SPLASH_RADIUS,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CartScreen()),
            );
          },
          icon: const Icon(Icons.shopping_cart)),
    );
  }
}
