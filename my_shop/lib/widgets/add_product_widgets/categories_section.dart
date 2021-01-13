import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_shop/providers/product_options.dart';
import 'file:///D:/Workspace/flutter%20projects/Friday/my_shop/lib/widgets/add_product_widgets/section_title.dart';
import 'package:my_shop/widgets/misc/product_options_list.dart';
import 'package:provider/provider.dart';

class CategoriesSection extends StatelessWidget {
  final String currentValue;
  final Function onSelected;

  CategoriesSection(this.currentValue, this.onSelected);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(
          'What is the category of this product',
          'Select the product so the customers can find it while they filter products.',
        ),
        ProductOptionsList(
          Provider.of<ProductOptionsProvider>(context).categories,
          currentValue,
          onSelected,
        ),
      ],
    );
  }
}
