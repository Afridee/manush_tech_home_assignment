

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:manush_tech_assignment/Screens/loginPage.dart';
import 'package:manush_tech_assignment/Screens/shop.dart';

import '../services/authService.dart';

class LoggedInOrNot extends StatefulWidget {
  const LoggedInOrNot({Key? key}) : super(key: key);

  @override
  State<LoggedInOrNot> createState() => _LoggedInOrNotState();
}

class _LoggedInOrNotState extends State<LoggedInOrNot> {

  final AuthService authService = Get.put(AuthService());

  @override
  void initState() {
    authService.getUserAndAuthToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthService>(builder: (as){
      return as.user==null && as.authToken==null ? SignInScreen() : Shop();
    });
  }
}
