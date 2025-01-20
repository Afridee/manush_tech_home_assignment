import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manush_tech_assignment/Screens/cart.dart';
import 'package:manush_tech_assignment/services/authService.dart';

import 'Screens/loggedInOrNot.dart';
import 'Screens/loginPage.dart';
import 'Screens/shop.dart';
import 'models/user.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: LoggedInOrNot(),
    );
  }
}
