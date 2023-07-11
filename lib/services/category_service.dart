import 'dart:convert';

import 'package:ecommerce_app/constant/api.dart';
import 'package:ecommerce_app/models/category_model.dart';
import 'package:ecommerce_app/services/api_service.dart';

class CategoryService {
  static Future<List<Category>> getCategoryies(
      {Map<String, String>? queryParams}) async {
    try {
      var response =
          await ApiService.httpGet(categoryUri, queryParams: queryParams);
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        List<Category> categories = [];
        for (var item in body) {
          categories.add(Category.fromJson(item));
        }
        return categories;
      } else {
        throw ("failed to fetch categories");
      }
    } catch (e) {
      throw ('Error during fetch categories');
    }
  }
}
