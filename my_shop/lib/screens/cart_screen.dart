import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_shop/providers/cart.dart';
import 'package:my_shop/providers/cart.dart';
//import 'package:my_shop/screens/checkout_screen.dart';
import 'package:my_shop/widgets/cart_widgets/cart_item_widget.dart';
import 'package:provider/provider.dart';

import 'checkout_screen.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
        actions: [
          FlatButton(
            child: Text(
              'Clear',
              style: TextStyle(color: Colors.red),
            ),
            onPressed: () {
              Provider.of<Cart>(context, listen: false).clearCart();
              Navigator.of(context).pop();
              Fluttertoast.showToast(
                  msg: "Cart has been cleared.",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red[900],
                  textColor: Colors.white,
                  fontSize: 16.0);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 10),
              itemCount: Provider.of<Cart>(context).items.length,
              itemBuilder: (context, index) {
                return CartItemWidget(Provider.of<Cart>(context).items[index]);
              },
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total',
                      style: TextStyle(color: Colors.grey[800]),
                    ),
                    Text(
                      Provider.of<Cart>(context).amount.toStringAsFixed(2),
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                RaisedButton(
                  color: Colors.black,
                  onPressed: () {
                    Navigator.of(context).pushNamed(CheckoutScreen.routeName);
                  },
                  child: Row(
                    children: [
                      Text(
                        'Checkout',
                        style: TextStyle(color: Colors.white),
                      ),
                      Icon(
                        Icons.arrow_right,
                        color: Colors.white,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
