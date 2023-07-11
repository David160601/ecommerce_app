import 'dart:convert';

import 'package:ecommerce_app/constant/api.dart';
import 'package:ecommerce_app/models/product_%20model.dart';
import 'package:ecommerce_app/services/api_service.dart';

class ProductService {
  static Future<List<Product>> getProducts(
      {Map<String, String>? queryParams}) async {
    try {
      var response =
          await ApiService.httpGet(productUri, queryParams: queryParams);
      if (response.statusCode == 200) {
        List<Product> products = [];
        var body = jsonDecode(response.body);
        for (var item in body) {
          products.add(Product.fromJson(item));
        }

        return products;
      } else {
        throw Exception("Faild to fetch products");
      }
    } catch (e) {
      throw Exception('An error occurred during product retrieval: $e');
    }
  }
}
