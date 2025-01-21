import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:manush_tech_assignment/models/user.dart';
import 'package:manush_tech_assignment/models/product.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants.dart';
import '../models/cart.dart';

class CartService extends GetxController {

  final dio = Dio();
  bool isLoading = false;
  List<Product> products = [];
  Cart cart = Cart(items: []);

  initializeCart() async{
    final prefs = await SharedPreferences.getInstance();
    String? cartJson = prefs.getString('cart');
    if (cartJson != null){
      cart = Cart.fromJson(json.decode(cartJson));
      update();
    }
  }

  Future<void> saveCartData() async {
    final prefs = await SharedPreferences.getInstance();
    String cartJson = json.encode(cart.toJson());
    await prefs.setString('cart', cartJson);
  }

  Future<void> deleteCart() async {
    cart = Cart(items: []);
    update();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('cart');
  }

  addToCart({required Product product }){
     cart.addItem(product, 1);
     update();
     saveCartData();
  }

  removeFromCart({required Product product}){
    cart.items.removeWhere((item) => item.product.title==product.title);
    update();
    saveCartData();
  }

  addQTY({required Product product}){
    cart.items.where((item) => item.product.title==product.title).first.add();

    if(cart.items.where((item) => item.product.title==product.title).first.gifts.isNotEmpty){
      Get.snackbar(
        "Congrats!!",
        "You have recieved a gift!!🎉🎉",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.deepPurple,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
    }

    if(cart.items.where((item) => item.product.title==product.title).first.discount>0){
      Get.snackbar(
        "Congrats!!",
        "You've earned a discount'!!🎉🎉",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.deepPurple,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
    }

    update();
    saveCartData();
  }

  deductQTY({required Product product}){
    cart.items.where((item) => item.product.title==product.title).first.deduct();
    if(cart.items.where((item) => item.product.title==product.title).first.quantity==0){
      removeFromCart(product: product);
    }
    update();
    saveCartData();
  }

  bool existsInCart({required Product product}){
    return cart.items.where((item) => item.product.title==product.title).isNotEmpty;
  }

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