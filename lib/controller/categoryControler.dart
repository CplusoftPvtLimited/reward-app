import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rewardapp/model/categoryModel.dart';
import 'package:http/http.dart' as http;
import 'package:rewardapp/utils/api_url.dart';

class CategoryController with ChangeNotifier {
  List<CategoryModel> _category = [];

  List<CategoryModel> get category {
    return [..._category];
  }

  Future<void> getCategories() async {
    try {
      var response = await http
          .get(Uri.parse('${ApiUrl.BASE_URL}${ApiUrl.CATEGORY_ENDPOINT}'));

      var decodedProducts = jsonDecode(response.body)['collections'];

      if (!_category.any((element) => element.id == decodedProducts['id'])) {
        (decodedProducts as List<dynamic>).forEach((element) {
          print(element);
          _category.add(CategoryModel.fromJson(element));
          notifyListeners();
        });
      }
    } catch (e) {
      print(e);
    }
  }
}
