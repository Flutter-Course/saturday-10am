import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_shop/providers/product_options.dart';
import 'package:my_shop/widgets/misc/product_option_item.dart';

class ProductOptionsList extends StatelessWidget {
  final List<ProductOption> options;
  final String groupValue;
  final Function onChanged;
  ProductOptionsList(this.options, this.groupValue, this.onChanged);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.2,
      width: double.infinity,
      child: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 10),
        physics: BouncingScrollPhysics(),
        itemExtent: 150,
        scrollDirection: Axis.horizontal,
        itemCount: options.length,
        itemBuilder: (context, index) {
          return ProductOptionItem(options[index], groupValue, onChanged);
        },
      ),
    );
  }
}
