import 'package:manush_tech_assignment/models/discountProduct.dart';

import 'cartItem.dart';
import 'product.dart';

class Cart {
  List<CartItem> items;

  Cart({required this.items});

  void addItem(Product product, int quantity) {
    CartItem item = CartItem(product: product, quantity: quantity, discount: 0, gifts: []);
    item.computeGift();
    item.computeDiscount();
    items.add(item);
  }

  double getTotalCost() {
    double totalCost = 0;
    for (var item in items) {
      totalCost += item.quantity * item.product.mrp;
    }
    return totalCost;
  }

  double getTotalDiscount() {
    double totalDiscount = 0;
    for (var item in items) {
      totalDiscount += item.discount;
    }
    return totalDiscount;
  }

  List<DiscountProduct> getTotalGifts() {
    List<DiscountProduct> gifts = [];
    for (var item in items) {
      gifts.addAll(item.gifts);
    }
    return gifts;
  }

  // Function to get a summary of all items in the cart
  void getCartSummary() {
    for (var item in items) {
      print("Product: ${item.product.title}, Quantity: ${item.quantity}, Total Weight: ${item.getTotalWeight()}${item.product.weightUnit}, Discount: \$${item.discount}");
      var gifts = item.gifts;
      if (gifts.isNotEmpty) {
        print("Gifts with purchase:");
        gifts.forEach((gift) {
          print(" -> ${gift.title}");
        });
      }
    }
    print("Total Cost: \$${getTotalCost()}");
    print("Total Discount: \$${getTotalDiscount()}");
    print("Total Gifts: ${getTotalGifts().length}");
  }

  // Deserialize from JSON
  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      items: (json['items'] as List)
          .map((item) => CartItem.fromJson(item))
          .toList(),
    );
  }

  // Serialize to JSON
  Map<String, dynamic> toJson() {
    return {
      'items': items.map((item) => item.toJson()).toList(),
    };
  }
}
