import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rewardapp/view/auth_screens/login.dart';
import 'package:rewardapp/view/auth_screens/register.dart';
import 'package:rewardapp/view/other_screens/bottom_nav.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthCheck extends StatefulWidget {
  const AuthCheck({super.key});

  @override
  State<AuthCheck> createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  Future<bool> authCheck() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      if (prefs.getString('user')!.isNotEmpty) {
        print("User Logged In");
        return true;
      } else {
        print("User NOt Logged In");

        return false;
      }
    } catch (e) {
      print(e);
    }
    return false;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    authCheck();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: authCheck(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data == true) {
            return BottomNavBarScreen();
          } else {
            return SignInScreen();
          }
        }
        return SignInScreen();
      },
    );
  }
}
