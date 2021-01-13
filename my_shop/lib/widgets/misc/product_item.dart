import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

//import 'package:my_shop/models/cart.dart';
import 'package:my_shop/models/product.dart';
import 'package:my_shop/providers/cart.dart';
import 'package:my_shop/screens/edit_product_screen.dart';
import 'package:my_shop/screens/product_details_screen.dart';

//import 'package:my_shop/screens/edit_product_screen.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  final bool edit;

  ProductItem(this.product, [this.edit = true]);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ProductDetailsScreen(product),
              ),
            );
          },
          child: Card(
            margin: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                      ),
                      child: Hero(
                        tag: product.photosUrls[0],
                        child: CarouselSlider(
                          options: CarouselOptions(
                            autoPlay: true,
                            enableInfiniteScroll: false,
                            viewportFraction: 1,
                            aspectRatio: 1 / 1,
                          ),
                          items: product.photosUrls
                              .map((e) => Image.network(
                                    e,
                                    fit: BoxFit.cover,
                                  ))
                              .toList(),
                        ),
                      )),
                  flex: 10,
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            product.title,
                            style: TextStyle(fontWeight: FontWeight.bold),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Expanded(
                          child: Text('\$${product.price}'),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(8),
                            topLeft: Radius.circular(8),
                          )),
                      child: FittedBox(
                        child: Text(
                          '${product.forWho} ${product.category}',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          child: (edit)
              ? IconButton(
                  icon: Icon(Icons.settings),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => EditProductScreen(product)));
                  },
                )
              : AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  margin: EdgeInsets.only(top: 10, right: 10),
                  width: Provider.of<Cart>(context).itemCount(product) != 0
                      ? 70
                      : 70 / 3,
                  height: 20,
                  padding: EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Provider.of<Cart>(context, listen: false)
                                .addProduct(product);
                            Fluttertoast.showToast(
                              msg: "Item has been added.",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.black,
                              textColor: Colors.white,
                              fontSize: 16.0,
                            );
                          },
                          child: Container(
                            height: double.infinity,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: Provider.of<Cart>(context)
                                          .itemCount(product) !=
                                      0
                                  ? BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      bottomLeft: Radius.circular(20),
                                    )
                                  : BorderRadius.circular(20),
                            ),
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 15,
                            ),
                          ),
                        ),
                      ),
                      if (Provider.of<Cart>(context).itemCount(product) != 0)
                        Expanded(
                          child: Center(
                            child: Text(
                              Provider.of<Cart>(context)
                                  .itemCount(product)
                                  .toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      if (Provider.of<Cart>(context).itemCount(product) != 0)
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              Provider.of<Cart>(context, listen: false)
                                  .removeProduct(product);
                              Fluttertoast.showToast(
                                  msg: "Item has been removed.",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.black,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            },
                            child: Container(
                              height: double.infinity,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                ),
                              ),
                              child: Icon(
                                Icons.remove,
                                color: Colors.white,
                                size: 15,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
          right: 0,
          top: 0,
        ),
        if (product.photosUrls.length > 1)
          Positioned(
            child: IconButton(
              icon: Icon(Icons.photo_library),
              disabledColor: Colors.black,
              onPressed: null,
            ),
            left: 0,
            top: 0,
          ),
      ],
    );
  }
}
