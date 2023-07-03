import 'package:ecommerce_app/models/product_%20model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CartNotifier extends StateNotifier<List<Product>> {
  CartNotifier() : super([]);
  final storage = new FlutterSecureStorage();
  void addProductToCart(Product product) {
    if (!state.contains(product)) {
      state = [...state, product];
    }
  }

  void removeProductFromCart(Product product) {
    state = state.where((item) => product.id != item.id).toList();
  }
}

final cartProvider = StateNotifierProvider<CartNotifier, List<Product>>((ref) {
  return CartNotifier();
});
