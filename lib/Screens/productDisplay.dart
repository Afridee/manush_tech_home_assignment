import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:manush_tech_assignment/models/cart.dart';
import 'package:manush_tech_assignment/models/cartItem.dart';
import '../models/discountProduct.dart';
import '../models/product.dart';
import '../services/cartService.dart';

// Assuming you have already defined the Product and related classes as above
class ProductDisplayScreen extends StatefulWidget {
  final Product product;

  const ProductDisplayScreen({Key? key, required this.product}) : super(key: key);

  @override
  _ProductDisplayScreenState createState() => _ProductDisplayScreenState();
}

class _ProductDisplayScreenState extends State<ProductDisplayScreen> {

  final CartService cartService = Get.put(CartService());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            if (widget.product.productImages.isNotEmpty)
              CarouselSlider(
                options: CarouselOptions(
                  autoPlay: true,
                  aspectRatio: 2.0,
                  enlargeCenterPage: true,
                  height: 400
                ),
                items: widget.product.productImages.map((item) => Container(
                  child: Center(
                      child: Image.network(item.image, fit: BoxFit.fitHeight)
                  ),
                )).toList(),
              ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.product.title,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('SKU: ${widget.product.sku}'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Price: \$${widget.product.mrp.toStringAsFixed(2)}'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Stock: ${widget.product.stock}'),
            ),
            if (widget.product.promotion != null)
              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 8),
                child: Text('Promotion: ${widget.product.promotion!.title}'),
              ),
            SizedBox(height: 20),
            GetBuilder<CartService>(builder: (cs){
              return cs.existsInCart(product: widget.product) ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.remove_circle, color: Colors.deepPurple, size: 30),
                      onPressed: () {
                        cartService.deductQTY(product: widget.product);
                      },
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        '${cs.cart.items.where((item) => item.product.title==widget.product.title).first.quantity}', // This would dynamically display the current quantity
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.add_circle, color: Colors.deepPurple, size: 30),
                      onPressed: () {
                        cartService.addQTY(product: widget.product);
                      },
                    ),
                  ],
                ),
              ) :
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    cartService.addToCart(product: widget.product);
                  },
                  child: Text('Add to Cart', style: TextStyle(fontSize: 20)),
                ),
              );
            }),
            SizedBox(height: 30)
          ],
        ),
      ),
    );
  }
}
