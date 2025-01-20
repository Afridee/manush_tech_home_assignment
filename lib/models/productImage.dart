
class ProductImage {
  final int id;
  final String image;

  ProductImage({
    required this.id,
    required this.image,
  });

  factory ProductImage.fromJson(Map<String, dynamic> json) => ProductImage(
    id: json['id'],
    image: json['image'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'image': image,
  };
}