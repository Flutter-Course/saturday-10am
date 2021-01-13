import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_shop/models/product.dart';

class ProductsProvider with ChangeNotifier {
  List<Product> selectedProducts;

  String category, forWho;
  double priceFrom, priceTo;

  void updateFilters(category, forWho, priceFrom, priceTo) {
    this.category = category;
    this.forWho = forWho;
    this.priceFrom = priceFrom;
    this.priceTo = priceTo;
    notifyListeners();
  }

  void clearFilters() {
    category = null;
    forWho = null;
    priceFrom = null;
    priceTo = null;
    notifyListeners();
  }

  Future<bool> fetchProducts() async {
    try {
      Query query = FirebaseFirestore.instance.collection('products');

      if (category != null) {
        query = query.where('category', isEqualTo: category);
      }

      if (forWho != null) {
        query = query.where('forWho', isEqualTo: forWho);
      }

      if (priceFrom != null) {
        query = query.where('price',
            isGreaterThanOrEqualTo: priceFrom, isLessThanOrEqualTo: priceTo);
      }

      final queryData = await query.get();
      print(queryData.docs.length);
      selectedProducts = queryData.docs
          .map((document) => Product.fromDocument(document))
          .toList();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
