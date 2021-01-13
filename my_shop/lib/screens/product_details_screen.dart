import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_shop/models/product.dart';
import 'package:my_shop/models/review.dart';
import 'package:my_shop/widgets/product_details_widgets/add_review_sheet.dart';
import 'package:my_shop/widgets/product_details_widgets/review_widget.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Product product;

  ProductDetailsScreen(this.product);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        isExtended: true,
        backgroundColor: Colors.black,
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            isDismissible: false,
            builder: (context) {
              return AddReviewSheet(product.id);
            },
          );
        },
        icon: Icon(
          Icons.add,
          color: Colors.white,
        ),
        label: Text(
          'Add Review',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.5,
                child: Hero(
                  tag: product.photosUrls[0],
                  child: CarouselSlider(
                    options: CarouselOptions(
                      autoPlay: true,
                      enableInfiniteScroll: false,
                      viewportFraction: 1,
                      height: MediaQuery.of(context).size.height * 0.5,
                    ),
                    items: product.photosUrls
                        .map(
                          (e) => Container(
                            width: double.infinity,
                            height: double.infinity,
                            child: Image.network(
                              e,
                              fit: BoxFit.fill,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
              Positioned(
                top: 20,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      gradient: RadialGradient(
                        colors: [
                          Colors.black,
                          Colors.black45,
                          Colors.black.withOpacity(0),
                        ],
                      ),
                    ),
                    child: Icon(
                      Icons.chevron_left,
                      size: 35,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.fromLTRB(16, 16, 0, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  product.title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Card(
                  margin: EdgeInsets.zero,
                  elevation: 10,
                  color: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: Text(
                      product.forWho + ' ' + product.category,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Price:',
                  style: TextStyle(
                    //style
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  product.price.toStringAsFixed(2),
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 16, top: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Description:',
                  style: TextStyle(
                    //style
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Text(
                    product.description,
                    softWrap: true,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(16, 10, 16, 0),
            child: Text(
              'Reviews:',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('products')
                  .doc(product.id)
                  .collection('reviews')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error has occurred'),
                  );
                } else if (snapshot.hasData) {
                  return ListView(
                    padding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 16).add(
                      EdgeInsets.only(
                        bottom: kFloatingActionButtonMargin + 46,
                      ),
                    ),
                    children: (snapshot.data as QuerySnapshot)
                        .docs
                        .map((e) => ReviewWidget(Review.fromFirestore(e)))
                        .toList(),
                  );
                } else {
                  return Center(
                    child: Text('No Reviews Yet!'),
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
