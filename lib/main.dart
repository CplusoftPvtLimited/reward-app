import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rewardapp/controller/categoryControler.dart';
import 'package:rewardapp/controller/product_controller.dart';
import 'package:rewardapp/controller/storeController.dart';
import 'package:rewardapp/utils/auth_check.dart';

import 'view/auth_screens/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => StoreController(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProductController(),
        ),
        ChangeNotifierProvider(
          create: (context) => CategoryController(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: AuthCheck(),
      ),
    );
  }
}
