import 'package:manush_tech_assignment/models/discountProduct.dart';
import 'package:manush_tech_assignment/models/product.dart';
import 'package:manush_tech_assignment/models/promotion.dart';

class CartItem {
  Product product;
  int quantity;
  List<DiscountProduct> gifts;
  double discount;

  CartItem({required this.product, required this.quantity, required this.gifts, required this.discount});

  add(){
    quantity = quantity + 1;
    computeDiscount();
    computeGift();
  }

  deduct(){
    if(quantity>=1){
      quantity = quantity - 1;
      computeDiscount();
      computeGift();
    }
  }

  double getTotalWeight() {
    return product.weight * quantity;
  }

  computeDiscount() {
    double totalWeight = getTotalWeight();
    double discount = 0;
    Promotion? promotion = product.promotion;
    if (promotion != null && promotion.type=="WEIGHT") {
      for (var detail in promotion.promotionDetails) {
        if (totalWeight >= detail.minWeight && (detail.maxWeight == null || totalWeight <= detail.maxWeight!)) {
          int intervals = (totalWeight / detail.ruleWeight).floor();
          discount += intervals * (detail.amount ?? 0);
        }
      }
    }
    this.discount = discount;
  }

  computeGift() {
    double totalWeight = getTotalWeight();
    List<DiscountProduct> gifts = [];
    Promotion? promotion = product.promotion;
    if (promotion != null && promotion.type=="GWP") {
      for (var detail in promotion.promotionDetails) {
        if (totalWeight >= detail.minWeight && (detail.discountProduct != null)) {
          int intervals = (totalWeight / detail.ruleWeight).floor();
          for (int i = 0; i < intervals; i++) {
            for (int j = 0; j < detail.amount!.toInt(); j++) {
              gifts.add(detail.discountProduct!);
            }
          }
        }
      }
    }
    this.gifts = gifts;
  }


  // Deserialize from JSON
  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      product: Product.fromJson(json['product']),
      quantity: json['quantity'],
      gifts: (json['gifts'] as List)
          .map((gift) => DiscountProduct.fromJson(gift))
          .toList(),
      discount: json['discount'],
    );
  }

  // Serialize to JSON
  Map<String, dynamic> toJson() {
    return {
      'product': product.toJson(),
      'quantity': quantity,
      'gifts': gifts.map((gift) => gift.toJson()).toList(),
      'discount': discount,
    };
  }
}
