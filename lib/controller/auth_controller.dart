import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rewardapp/model/user_model.dart';
import 'package:rewardapp/utils/api_url.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController with ChangeNotifier {
  Future<bool> Login(String email, String password) async {
    // Obtain shared preferences.
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    print(email);
    try {
      var response = await http.post(
          Uri.parse('${ApiUrl.BASE_URL}${ApiUrl.LOGIN_ENDPOINT}'),
          body: jsonEncode({"email": email, "password": password}),
          headers: {'Content-Type': 'application/json'});

      var result = jsonDecode(response.body)['customer'];

      if (result != null) {
        UserModel userModel =
            UserModel.fromJson(jsonDecode(response.body)['customer']);
        // print(userModel.toJson().toString());
        prefs.setString('user', userModel.toJson().toString());

        return true;
      } else {
        return false;
      }
    } catch (e) {
      // ignore: avoid_print
      print("Error : $e");
    }
    return false;
  }

  Future<bool> SignUp(
      String firstname, String lastname, String email, String password) async {
    try {
      var response = await http
          .post(Uri.parse('${ApiUrl.BASE_URL}${ApiUrl.SIGNUP_ENDPOINT}'),
              body: jsonEncode({
                "first_name": firstname,
                "last_name": lastname,
                "email": email,
                "password": password,
              }),
              headers: {'Content-Type': 'application/json'});
      print(jsonDecode(response.body));
      if (response.statusCode == 200) {
        print(jsonDecode(response.body));
        return true;
      }
    } catch (e) {
      print(e);
      return false;
    }
    return false;
  }
}
