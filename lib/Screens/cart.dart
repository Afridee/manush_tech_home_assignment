import 'package:flutter/material.dart';

class CartItem {
  String id;
  String title;
  double price;
  int quantity;
  String imageUrl;

  CartItem({required this.id, required this.title, required this.price, required this.quantity, required this.imageUrl});
}

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<CartItem> cartItems = [
    CartItem(
      id: '1',
      title: 'Apple',
      price: 1.99,
      quantity: 1,
      imageUrl: 'https://cdn.pixabay.com/photo/2016/11/18/13/47/apple-1834639_1280.jpg',
    ),
    CartItem(
      id: '2',
      title: 'Banana',
      price: 0.79,
      quantity: 3,
      imageUrl: 'https://cdn.pixabay.com/photo/2016/09/03/20/48/bananas-1642706_640.jpg',
    ),
  ];

  void incrementQuantity(int index) {
    setState(() {
      cartItems[index].quantity++;
    });
  }

  void decrementQuantity(int index) {
    if (cartItems[index].quantity > 1) {
      setState(() {
        cartItems[index].quantity--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: () {
              setState(() {
                cartItems.clear();
              });
            },
          )
        ],
      ),
      body: cartItems.isNotEmpty
          ? Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                CartItem item = cartItems[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(item.imageUrl),
                      ),
                      title: Text(item.title),
                      subtitle: Text('Total: \$${(item.price * item.quantity).toStringAsFixed(2)}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.remove),
                            onPressed: () => decrementQuantity(index),
                          ),
                          Text(item.quantity.toString()),
                          IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () => incrementQuantity(index),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Total', style: TextStyle(fontSize: 20)),
                  Spacer(),
                  Chip(
                    label: Text(
                      '\$200',
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  TextButton(
                    child: Text('ORDER NOW'),
                    style: TextButton.styleFrom(primary: Theme.of(context).primaryColor),
                    onPressed: () {
                      // Place the order logic
                      print('Order placed!');
                    },
                  )
                ],
              ),
            ),
          )
        ],
      )
          : Center(
        child: Text("Your cart is empty", style: TextStyle(fontSize: 18)),
      ),
    );
  }
}
