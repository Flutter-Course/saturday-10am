import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_shop/providers/product_options.dart';

class ProductOptionItem extends StatelessWidget {
  final ProductOption productOption;
  final String groupValue;
  final Function onSelected;
  ProductOptionItem(this.productOption, this.groupValue, this.onSelected);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onSelected(productOption.title);
      },
      child: Card(
        color:
            productOption.title == groupValue ? Colors.grey[300] : Colors.white,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        margin: EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              productOption.photoPath,
              fit: BoxFit.cover,
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              productOption.title,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
