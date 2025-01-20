import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manush_tech_assignment/Screens/productDisplay.dart';
import 'package:manush_tech_assignment/models/product.dart';
import 'package:manush_tech_assignment/services/cartService.dart';
import '../services/authService.dart';

class Shop extends StatefulWidget {
  const Shop({Key? key}) : super(key: key);

  @override
  State<Shop> createState() => _ShopState();
}

class _ShopState extends State<Shop> {
  final AuthService authService = Get.put(AuthService());
  final CartService cartService = Get.put(CartService());
  Timer? debounceTimer;
  final int debounceDelay = 2000;
  List<Product> filteredProducts = [];

  initialize() async{
    await authService.getUserAndAuthToken();//remove this after
    await cartService.fetchProducts(authToken: authService.authToken!);
    filteredProducts = cartService.products;
  }

  @override
  void initState() {
    initialize();
    super.initState();
  }

  void Debounce(String value) {
    if (debounceTimer != null && debounceTimer!.isActive) {
      debounceTimer!.cancel(); // Cancel the previous timer if still active
    }
    // Start a new timer to debounce the function call
    debounceTimer = Timer(Duration(milliseconds: debounceDelay), () {
      filteredProducts = cartService.products.where((element) => element.title.toLowerCase().removeAllWhitespace.contains(value.removeAllWhitespace.toLowerCase())).toList();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartService>(builder: (cs) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Shop"),
          centerTitle: true,
        ),
        body: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextField(
                  //controller: _controller,
                  onChanged: (value) {
                    Debounce(value);
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Search products',
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                    contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide(color: Colors.black, width: 2.0),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Number of columns
                      crossAxisSpacing: 10, // Horizontal space between items
                      mainAxisSpacing: 10, // Vertical space between items
                      childAspectRatio: 0.71, // Aspect ratio of the cards
                    ),
                    itemCount: filteredProducts.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: (){
                          Get.to(()=>ProductDisplayScreen(product: filteredProducts[index] ));
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(23.0)),
                          elevation: 5.0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                ),
                                child: Image.network(
                                  filteredProducts[index].productImages.first.image,
                                  height: 120,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(filteredProducts[index].title,
                                    style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                                child: Text('\$${filteredProducts[index].mrp.toStringAsFixed(2)}',
                                    style: TextStyle(fontSize: 14.0, color: Colors.grey[600])),
                              ),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 3.0, left: 5, right: 5),
                                child: index==1 ? ElevatedButton(
                                  onPressed: () {
                                    // Handle add to cart here
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.deepPurple, // background (button) color
                                    onPrimary: Colors.white, // foreground (text) color
                                  ),
                                  child: Text('Add to Cart'),
                                ) : Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20)
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      IconButton(
                                        icon: Icon(Icons.remove_circle, color: Colors.deepPurple, size: 30),
                                        onPressed: () {
                                          // Deduct quantity functionality goes here
                                        },
                                      ),
                                      Container(
                                        child: Text(
                                          '1', // This would dynamically display the current quantity
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.add_circle, color: Colors.deepPurple, size: 30),
                                        onPressed: () {
                                          // Add quantity functionality goes here
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text(authService.user!.username),
                accountEmail: Text(authService.user!.phone),
              ),
              ListTile(
                leading: Icon(Icons.logout),
                title: Text('Logout'),
                onTap: () {
                  authService.signout();
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      );
    });
  }
}
