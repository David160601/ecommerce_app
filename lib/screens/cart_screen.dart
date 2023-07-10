import 'package:ecommerce_app/providers/cart_provider.dart';
import 'package:ecommerce_app/widgets/product_list_cart.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        title: const Text('Cart'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: ref.watch(cartProvider).length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      ProductListCartCard(
                          product: ref.watch(cartProvider)[index]),
                      const SizedBox(
                        height: 10,
                      )
                    ],
                  );
                },
              ),
              const SizedBox(
                  height:
                      80), // Adjust the height to accommodate the bottom sheet
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        width: double.infinity,
        color: Colors.white,
        padding: const EdgeInsets.all(20),
        child: ElevatedButton(
          onPressed: () {},
          child: const Text("Check out"),
        ),
      ),
    );
  }
}
