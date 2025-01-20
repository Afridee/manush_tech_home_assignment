import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:manush_tech_assignment/models/user.dart';
import 'package:manush_tech_assignment/models/product.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants.dart';

class CartService extends GetxController {

  final dio = Dio();
  bool isLoading = false;
  List<Product> products = [];

  fetchProducts({required String authToken}) async {
    isLoading = true;
    update();

    try {
      final rs = await dio.get(
        '$baseURL/api/v1/products',
        options: Options(headers: {
          'Authorization': authToken
        }),
      );

      if (rs.data['status'] == 200) {
        products = ProductsFromJson(json.encode(rs.data["data"]["products"]));
      }

      print(products);
    } catch (e, stack) {
      print(e);
      print(stack);
      Get.snackbar(
        "oops!!",
        "Something went wrong while fetching poducts!!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
    }

    isLoading = false;
    update();
  }
}