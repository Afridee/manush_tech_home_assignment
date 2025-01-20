import 'discountProduct.dart';

class PromotionDetail {
  final int id;
  final String? uid; ///some promotion detals objects from response doesn't have uid
  final String discountType;
  final double? amount;
  final double? percentage;
  final int ruleWeight;
  final int minWeight;
  final int? maxWeight;
  final String weightUnit;
  final DiscountProduct? discountProduct;

  PromotionDetail({
    required this.id,
    required this.uid,
    required this.discountType,
    this.amount,
    this.percentage,
    required this.ruleWeight,
    required this.minWeight,
    this.maxWeight,
    required this.weightUnit,
    this.discountProduct,
  });

  factory PromotionDetail.fromJson(Map<String, dynamic> json) => PromotionDetail(
    id: json['id'],
    uid: json['uid'],
    discountType: json['discountType'],
    amount: json['amount']?.toDouble(),
    percentage: json['percentage']?.toDouble(),
    ruleWeight: json['ruleWeight'],
    minWeight: json['minWeight'],
    maxWeight: json['maxWeight'] == null ? null : json['maxWeight'],
    weightUnit: json['weightUnit'],
    discountProduct: json['discountProduct'] == null ? null : DiscountProduct.fromJson(json['discountProduct']),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'uid': uid,
    'discountType': discountType,
    'amount': amount,
    'percentage': percentage,
    'ruleWeight': ruleWeight,
    'minWeight': minWeight,
    'maxWeight': maxWeight,
    'weightUnit': weightUnit,
    'discountProduct': discountProduct?.toJson(),
  };
}