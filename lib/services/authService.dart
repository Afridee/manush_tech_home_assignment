import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:manush_tech_assignment/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants.dart';

class AuthService extends GetxController {
  final dio = Dio();
  User? user;
  String? authToken;
  final _storage = const FlutterSecureStorage();
  bool isLoading = false;

  getUserAndAuthToken() async {
    user = await getUser();
    authToken = await getAuthToken();
    print("User: $user");
    print("authToken: $authToken");
    update();
  }

  signin({required String identifier, required String password}) async {
    isLoading = true;
    update();

    try {
      final rs = await dio.post(
        "$baseURL/api/v1/auth/signin",
        data: {"identifier": identifier, "password": password},
      );

      if (rs.data['status'] == 200) {
        user = User.fromJson(rs.data["data"]["user"]);
        authToken = rs.data["data"]["token"];
        saveUser(user!);
        saveAuthToken(token: authToken!);
      }

      print("User:");
      print(user!.toJson());

      print(authToken);
    } catch (e) {
      if(e is DioException){
        Get.snackbar(
          "oops!!",
          e.response!.data.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );
      }else{
        Get.snackbar(
          "oops!!",
          "Something went wrong while signing in!!",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );
      }
      print(e);
    }

    isLoading = false;
    update();
  }

  signout() {
    user = null;
    authToken = null;
    deleteAuthToken();
    deleteUser();
    update();
  }

  ///Auth token saving and deleting

  Future<void> saveAuthToken({required String token}) async {
    await _storage.write(key: 'authToken', value: token);
  }

  Future<String?> getAuthToken() async {
    return await _storage.read(key: 'authToken');
  }

  Future<void> deleteAuthToken() async {
    await _storage.delete(key: 'authToken');
  }

  ///User saving and deleting

  Future<void> saveUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    String userJson =
        jsonEncode(user.toJson()); // Assuming User has a toJson method
    await prefs.setString('user', userJson);
  }

  Future<User?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    String? userJson = prefs.getString('user');
    if (userJson == null) return null;
    return User.fromJson(
        jsonDecode(userJson)); // Assuming User has a fromJson method
  }

  Future<void> deleteUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user');
  }
}
