import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/cartService.dart';

class CartScreen extends StatelessWidget {

  final CartService cartService = Get.put(CartService());

  @override
  Widget build(BuildContext context) {

    return GetBuilder<CartService>(builder: (cs){
      return Scaffold(
        appBar: AppBar(
          title: Text('My Cart', style: TextStyle(color: Colors.white)),
          centerTitle: true,
          backgroundColor: Colors.deepPurple,
          elevation: 0,
          iconTheme: const IconThemeData(
            color: Colors.white, //change your color here
          ),
        ),
        body: Container(
          color: Colors.deepPurple,
          child: Column(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24.0),
                      topRight: Radius.circular(24.0),
                    ),
                  ),
                  child: ListView.builder(
                    itemCount: cs.cart.items.length,
                    itemBuilder: (context, index) {
                      final item = cs.cart.items[index];
                      return Card(
                        elevation: 4,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  // Product Thumbnail
                                  Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200], // Add a subtle background color
                                      borderRadius: BorderRadius.circular(20), // Rounded corners
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1), // Soft shadow
                                          blurRadius: 8, // Blur radius
                                          offset: Offset(0, 4), // Vertical shadow offset
                                        ),
                                      ],
                                    ),
                                    padding: const EdgeInsets.all(8.0), // Add padding inside the container
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20), // Clip the image to match the container's border radius
                                      child: Image.network(
                                        item.product.productImages.first.image,
                                        fit: BoxFit.cover, // Ensure the image covers the container proportionally
                                        errorBuilder: (context, error, stackTrace) => Icon(
                                          Icons.image_not_supported,
                                          size: 50,
                                          color: Colors.grey, // Placeholder for failed image loading
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 16),
                                  // Product Details
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item.product.title,
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text('qty: ${item.quantity}'),
                                        SizedBox(height: 8),
                                        Row(
                                          children: [
                                            Text('\$${item.quantity*item.product.mrp}', style: TextStyle(decoration: item.discount >0 ? TextDecoration.lineThrough : null)),
                                            SizedBox(width: 5),
                                            if(item.discount>0)
                                            Text('\$${item.quantity*item.product.mrp - item.discount}', style: TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold)),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Quantity Control
                                  Column(
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.add_circle_outline),
                                        onPressed: () {
                                          cartService.addQTY(product: item.product);
                                        },
                                      ),
                                      Text(
                                        '${item.quantity}',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.remove_circle_outline),
                                        onPressed: () {
                                          cartService.deductQTY(product: item.product);
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              if(item.gifts.isNotEmpty)
                              Divider(),
                              if(item.gifts.isNotEmpty)
                              Text("Gifts:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17, color: Colors.deepPurple)),
                              if(item.gifts.isNotEmpty)
                              Row(
                                children: [
                                  Container(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200], // Add a subtle background color
                                      borderRadius: BorderRadius.circular(10), // Rounded corners
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1), // Soft shadow
                                          blurRadius: 8, // Blur radius
                                          offset: Offset(0, 4), // Vertical shadow offset
                                        ),
                                      ],
                                    ),
                                    padding: const EdgeInsets.all(8.0), // Add padding inside the container
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10), // Clip the image to match the container's border radius
                                      child: Image.network(
                                        item.gifts.first.productImages.first.image,
                                        fit: BoxFit.cover, // Ensure the image covers the container proportionally
                                        errorBuilder: (context, error, stackTrace) => Icon(
                                          Icons.image_not_supported,
                                          size: 50,
                                          color: Colors.grey, // Placeholder for failed image loading
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 16),
                                  Text("${item.gifts.first.title} x ${item.gifts.length}", style: TextStyle(fontSize: 18))
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              // Summary Section
              Container(
                color: Colors.white,
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '\$${cs.cart.getTotalCost()-cs.cart.getTotalDiscount()}',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        // Order Now logic
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.deepPurple,
                        padding:
                        EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Order Now',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
