import 'package:ecommerce_app/constant/style.dart';
import 'package:ecommerce_app/providers/cart_provider.dart';
import 'package:ecommerce_app/screens/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MainAppBar extends ConsumerStatefulWidget implements PreferredSizeWidget {
  final String title;
  const MainAppBar({super.key, required this.title});
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  @override
  ConsumerState<MainAppBar> createState() => _MainAppBarState();
}

class _MainAppBarState extends ConsumerState<MainAppBar> {
  @override
  Widget build(BuildContext context) {
    int productSize = ref.watch(cartProvider).length;
    return AppBar(
      title: Text(widget.title),
      surfaceTintColor: Colors.transparent,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20, top: 10),
          child: Badge(
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
          ),
        )
      ],
    );
  }
}
