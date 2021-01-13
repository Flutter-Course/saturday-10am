import 'package:flutter/material.dart';
import 'package:my_shop/models/cart_item.dart';
import 'package:my_shop/models/product.dart';

class Cart with ChangeNotifier {
  List<CartItem> items;
  Cart() {
    items = [];
  }

  int get itemsQuantity {
    int ret = 0;
    items.forEach((element) {
      ret += element.quantity;
    });
    return ret;
  }

  double get amount {
    double ret = 0;
    items.forEach((element) {
      ret += (element.quantity * element.product.price);
    });
    return ret;
  }

  void addProduct(Product product) {
    int index = items.indexWhere((element) => element.product.id == product.id);
    if (index == -1) {
      items.add(CartItem(product, 1));
    } else {
      items[index].quantity++;
    }
    notifyListeners();
  }

  void removeProduct(Product product) {
    int index = items.indexWhere((element) => element.product.id == product.id);
    items[index].quantity--;
    if (items[index].quantity == 0) {
      items.removeAt(index);
    }
    notifyListeners();
  }

  void clearCart() {
    items.clear();
    items = [];
    notifyListeners();
  }

  void clearItem(Product product) {
    int index = items.indexWhere((element) => element.product.id == product.id);
    items.removeAt(index);
    notifyListeners();
  }

  int itemCount(Product product) {
    int index = items.indexWhere((element) => element.product.id == product.id);
    if (index == -1) {
      return 0;
    } else {
      return items[index].quantity;
    }
  }
}
