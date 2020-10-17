import 'package:flutter/foundation.dart';

class Order {
  int id;
  String deliveryMan;
  double price;
  DateTime orderDate;

  Order(
      {@required this.id,
      @required this.deliveryMan,
      @required this.orderDate,
      @required this.price});
}
