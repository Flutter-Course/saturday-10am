import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_shop/providers/product_options.dart';
import 'file:///D:/Workspace/flutter%20projects/Friday/my_shop/lib/widgets/add_product_widgets/section_title.dart';
import 'package:my_shop/widgets/misc/product_options_list.dart';
import 'package:provider/provider.dart';

class ForWhoSection extends StatelessWidget {
  final String currentValue;
  final Function onSelected;

  ForWhoSection(this.currentValue, this.onSelected);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(
          'Who are the targeted people',
          'Pick the targeted people carefully so they can find your products easily.',
        ),
        ProductOptionsList(
          Provider.of<ProductOptionsProvider>(context).peopleTypes,
          currentValue,
          onSelected,
        ),
      ],
    );
  }
}
