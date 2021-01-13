import 'package:flutter/material.dart';
import 'package:my_shop/providers/cart.dart';
import 'package:my_shop/models/cart_item.dart';
import 'package:my_shop/providers/cart.dart';
import 'package:my_shop/widgets/misc/image_frame.dart';
import 'package:provider/provider.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem item;
  CartItemWidget(this.item);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 20,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Colors.grey[200],
      child: Container(
        height: MediaQuery.of(context).size.height * 0.15,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(16),
        child: Stack(
          children: [
            Row(
              children: [
                ImageFrame.fromNetwork(item.product.photosUrls[0], 0.5),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.product.title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: Text('\$${item.product.price}'),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.bottomCenter,
                                child: FittedBox(
                                  child: Row(
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.add),
                                        onPressed: () {
                                          Provider.of<Cart>(context,
                                                  listen: false)
                                              .addProduct(item.product);
                                        },
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                              width: 1,
                                              color: Colors.black,
                                            )),
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Text(item.quantity.toString()),
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.remove),
                                        onPressed: () {
                                          Provider.of<Cart>(context,
                                                  listen: false)
                                              .removeProduct(item.product);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            Positioned(
              right: 0,
              top: 0,
              child: InkWell(
                child: Icon(Icons.close),
                onTap: () {
                  Provider.of<Cart>(context, listen: false)
                      .clearItem(item.product);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
