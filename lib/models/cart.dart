import 'package:manush_tech_assignment/models/discountProduct.dart';

import 'cartItem.dart';
import 'product.dart';

class Cart {
  List<CartItem> items = [];

  void addItem(Product product, int quantity) {
    CartItem item = CartItem(product: product, quantity: quantity);
    items.add(item);
  }

  double getTotalDiscount() {
    double totalDiscount = 0;
    for (var item in items) {
      totalDiscount += item.computeDiscount();
    }
    return totalDiscount;
  }

  List<DiscountProduct> getTotalGifts() {
    List<DiscountProduct> gifts = [];
    for (var item in items) {
      gifts.addAll(item.computeGift());
    }
    return gifts;
  }

  // Function to get a summary of all items in the cart
  void getCartSummary() {
    for (var item in items) {
      print("Product: ${item.product.title}, Quantity: ${item.quantity}, Total Weight: ${item.getTotalWeight()}kg, Discount: \$${item.computeDiscount()}");
      var gifts = item.computeGift();
      if (gifts.isNotEmpty) {
        print("Gifts with purchase:");
        gifts.forEach((gift) {
          print(" -> ${gift.title}");
        });
      }
    }
    print("Total Discount: \$${getTotalDiscount()}");
    print("Total Gifts: ${getTotalGifts().length}");
  }
}
