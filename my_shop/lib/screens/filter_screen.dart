import 'package:flutter/material.dart';
import 'package:my_shop/providers/products_provider.dart';
import 'package:my_shop/widgets/add_product_widgets/categories_section.dart';
import 'package:my_shop/widgets/add_product_widgets/for_who_section.dart';
import 'package:provider/provider.dart';

class FilterScreen extends StatefulWidget {
  static const routeName = '/filter';

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen>
    with TickerProviderStateMixin {
  double priceFrom, priceTo;
  String category, forWho;

  @override
  void initState() {
    super.initState();
    priceFrom = 0;
    priceTo = 10000;
    category = 'Clothes';
    forWho = 'Men';
  }

  void changeCategory(String category) {
    setState(() {
      this.category = category;
    });
  }

  void changeForWho(String forWho) {
    setState(() {
      this.forWho = forWho;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'filter',
      child: Scaffold(
        appBar: AppBar(
          title: Text('Filter'),
          leading: IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                Navigator.of(context).pop(false);
              }),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              ForWhoSection(forWho, changeForWho),
              SizedBox(height: 20),
              CategoriesSection(category, changeCategory),
              SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Price Range',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${priceFrom.toStringAsFixed(2)}\$'),
                      Text('${priceTo.toStringAsFixed(2)}\$'),
                    ],
                  ),
                  RangeSlider(
                    values: RangeValues(priceFrom, priceTo),
                    min: 0,
                    max: 10000,
                    onChanged: (value) {
                      setState(() {
                        priceFrom = value.start;
                        priceTo = value.end;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FlatButton(
                    onPressed: () {
                      Provider.of<ProductsProvider>(context, listen: false)
                          .clearFilters();
                      Navigator.of(context).pop(true);
                    },
                    child: Text(
                      'Clear',
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.red,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  RaisedButton(
                    onPressed: () {
                      Provider.of<ProductsProvider>(context, listen: false)
                          .updateFilters(category, forWho, priceFrom, priceTo);
                      Navigator.of(context).pop(true);
                    },
                    child: Text(
                      'Filter',
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.black,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
