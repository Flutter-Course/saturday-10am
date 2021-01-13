import 'package:flutter/material.dart';
import 'package:my_shop/providers/cart.dart';
import 'package:my_shop/screens/cart_screen.dart';
import 'package:provider/provider.dart';

class ShoppingCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int count = Provider.of<Cart>(context).itemsQuantity;
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(CartScreen.routeName);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
        child: Stack(
          overflow: Overflow.visible,
          alignment: Alignment.center,
          children: [
            Icon(Icons.shopping_basket_sharp),
            Positioned(
              right: -7,
              top: -1,
              child: Container(
                padding: EdgeInsets.all(count <= 9 ? 6 : 3),
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  '${count <= 9 ? count : '9+'}',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
