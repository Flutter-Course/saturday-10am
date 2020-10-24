import 'package:delivery_manager/models/order.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderItem extends StatelessWidget {
  final Order order;
  final Function removeOrder;
  OrderItem(this.order, this.removeOrder);
  @override
  Widget build(BuildContext context) {
    bool dark = Theme.of(context).primaryColor == Colors.grey[900];
    return Card(
      color:
          dark ? Theme.of(context).primaryColor : Theme.of(context).accentColor,
      margin: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.04,
      ).add(
        EdgeInsets.only(
          bottom: 10,
        ),
      ),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 30,
            backgroundColor:
                dark ? Colors.black : Theme.of(context).primaryColor,
            child: FittedBox(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  '${order.price.toStringAsFixed(2)}\$',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          title: Text(
            order.deliveryMan,
            style: TextStyle(
              color: dark ? Colors.white : Colors.black,
            ),
          ),
          subtitle: Text(
            DateFormat('hh:mm a').format(order.orderDate),
            style: TextStyle(
              color: dark ? Colors.white : Colors.black,
            ),
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.delete,
              color: Colors.red,
            ),
            onPressed: () {
              removeOrder(
                  DateFormat('yyyyMMdd').format(order.orderDate), order);
            },
          ),
        ),
      ),
    );
  }
}
