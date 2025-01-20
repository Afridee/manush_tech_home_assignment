import 'package:manush_tech_assignment/models/discountProduct.dart';
import 'package:manush_tech_assignment/models/product.dart';
import 'package:manush_tech_assignment/models/promotion.dart';

class CartItem {
  Product product;
  int quantity;

  CartItem({required this.product, required this.quantity});

  double getTotalWeight() {
    return product.weight * quantity;
  }

  double computeDiscount() {
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
    return discount;
  }

  List<DiscountProduct> computeGift() {
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
    return gifts;
  }
}
