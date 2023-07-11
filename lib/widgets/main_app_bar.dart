
import 'package:ecommerce_app/widgets/cart_icon.dart';
import 'package:flutter/material.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const MainAppBar({super.key, required this.title});
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      leading: IconButton(
        splashRadius: 20,
        icon: const Icon(Icons.menu),
        onPressed: () => Scaffold.of(context).openDrawer(),
      ),
      surfaceTintColor: Colors.transparent,
      actions: const [
        Padding(
          padding: EdgeInsets.only(right: 20, top: 10),
          child: CardIcon(),
        )
      ],
    );
  }
}
