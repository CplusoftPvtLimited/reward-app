import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/storeModel.dart';

class StoreController with ChangeNotifier {
  List<StoreModel> _stores = [];

  List<StoreModel> get stores {
    return [..._stores];
  }

  Future<void> getStores() async {
    try {
      var response = await http
          .get(Uri.parse("https://medusa.backend.cplusoft.info/api/store"));

      var decodedResponse = jsonDecode(response.body)['data'];

      if (!_stores.any((element) => element.id == decodedResponse['id'])) {
        (decodedResponse as List<dynamic>).forEach((element) {
          _stores.add(StoreModel.fromJson(element));
          notifyListeners();
        });
      }
    } catch (e) {
      print(e);
    }
  }
}
