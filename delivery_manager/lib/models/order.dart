import 'package:flutter/foundation.dart';

class Order {
  static int _counter = 0;
  int id;
  String deliveryMan;
  double price;
  DateTime orderDate;

  Order(
      {@required this.deliveryMan,
      @required this.orderDate,
      @required this.price}) {
    this.id = ++_counter;
  }
}
