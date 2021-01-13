import 'package:flutter/material.dart';

class ProductOption {
  String _title, _photoPath;

  String get title => _title;

  String get photoPath => _photoPath;

  ProductOption(this._title, this._photoPath);
}

class ProductOptionsProvider with ChangeNotifier {
  List<ProductOption> _categories;
  List<ProductOption> _peopleTypes;
  ProductOptionsProvider() {
    _categories = [
      ProductOption('Clothes', 'assets/images/clothes.png'),
      ProductOption('Footwear', 'assets/images/footwear.png'),
      ProductOption('Eyewear', 'assets/images/eyewear.png'),
      ProductOption('Watches', 'assets/images/watches.png'),
      ProductOption('Bags', 'assets/images/bags.png'),
      ProductOption('Accessories', 'assets/images/accessories.png'),
      ProductOption('Jewelery', 'assets/images/jewelery.png'),
    ];
    _peopleTypes = [
      ProductOption('Men', 'assets/images/men.png'),
      ProductOption('Women', 'assets/images/women.png'),
      ProductOption('Men & Women', 'assets/images/unisex.png'),
      ProductOption('Kids & Babies', 'assets/images/babies.png'),
    ];
  }

  List<ProductOption> get categories => [..._categories];
  List<ProductOption> get peopleTypes => [..._peopleTypes];
}
