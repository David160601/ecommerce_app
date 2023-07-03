import 'dart:convert';

import 'package:ecommerce_app/models/product_%20model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CartNotifier extends StateNotifier<List<Product>> {
  CartNotifier() : super([]) {
    initializeState();
  }
  final storage = new FlutterSecureStorage();
  bool addProductToCart(Product product) {
    bool exists = state.any((element) => element.id == product.id);
    if (!exists) {
      state = [...state, product];
      storage.write(key: "cartProducts", value: jsonEncode(state));
      return true;
    } else {
      return false;
    }
  }

  Future initializeState() async {
    String? cartProducts = await storage.read(key: "cartProducts");

    if (cartProducts != null && cartProducts.isNotEmpty) {
      List<dynamic> productList = json.decode(cartProducts);
      List<Product> products = [];
      for (var item in productList) {
        products.add(Product.fromJson(item));
      }
      state = products;
    }
  }

  void removeProductFromCart(Product product) {
    state = state.where((item) => product.id != item.id).toList();
    storage.write(key: "cartProducts", value: jsonEncode(state));
  }
}

final cartProvider = StateNotifierProvider<CartNotifier, List<Product>>((ref) {
  return CartNotifier();
});
