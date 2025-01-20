
import 'productImage.dart';

class DiscountProduct {
  final int id;
  final String title;
  final List<ProductImage> productImages;

  DiscountProduct({
    required this.id,
    required this.title,
    required this.productImages,
  });

  factory DiscountProduct.fromJson(Map<String, dynamic> json) => DiscountProduct(
    id: json['id'],
    title: json['title'],
    productImages: List<ProductImage>.from(json['productImages'].map((x) => ProductImage.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'productImages': List<dynamic>.from(productImages.map((x) => x.toJson())),
  };
}