import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rewardapp/model/product.dart';
import 'package:http/http.dart' as http;
import 'package:rewardapp/utils/api_url.dart';

class ProductController with ChangeNotifier {
  List<Product> _products = [];

  List<Product> get products {
    return [..._products];
  }

  Future<void> getProducts() async {
    try {
      var response = await http
          .get(Uri.parse('${ApiUrl.BASE_URL}${ApiUrl.PRODUCT_ENPOINT}'));

      var decodedProducts = jsonDecode(response.body)['products'];

      if (!_products.any((element) => element.id == decodedProducts['id'])) {
        (decodedProducts as List<dynamic>).forEach((element) {
          _products.add(Product.fromJson(element));
          notifyListeners();
        });
      }
    } catch (e) {
      print(e);
    }
  }
}
