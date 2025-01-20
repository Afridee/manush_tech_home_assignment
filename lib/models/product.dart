import 'dart:convert';
import 'productImage.dart';
import 'promotion.dart';

List<Product> ProductsFromJson(String str) => List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

class Product {
  final int id;
  final String uid;
  final String title;
  final String sku;
  final double weight;
  final String weightUnit;
  final int minimumOrderQuantity;
  final double mrp;
  final int stock;
  final List<ProductImage> productImages;
  final Promotion? promotion;

  Product({
    required this.id,
    required this.uid,
    required this.title,
    required this.sku,
    required this.weight,
    required this.weightUnit,
    required this.minimumOrderQuantity,
    required this.mrp,
    required this.stock,
    required this.productImages,
    this.promotion,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json['id'],
    uid: json['uid'],
    title: json['title'],
    sku: json['sku'],
    weight: json['weight'].toDouble(),
    weightUnit: json['weightUnit'],
    minimumOrderQuantity: json['minimumOrderQuantity'],
    mrp: json['mrp'].toDouble(),
    stock: json['stock'],
    productImages:  List<ProductImage>.from(json['prouductImages'].map((x) => ProductImage.fromJson(x))),
    promotion: json['promotion'] == null ? null : Promotion.fromJson(json['promotion']),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'uid': uid,
    'title': title,
    'sku': sku,
    'weight': weight,
    'weightUnit': weightUnit,
    'minimumOrderQuantity': minimumOrderQuantity,
    'mrp': mrp,
    'stock': stock,
    'prouductImages': List<dynamic>.from(productImages.map((x) => x.toJson())),
    'promotion': promotion?.toJson(),
  };
}

