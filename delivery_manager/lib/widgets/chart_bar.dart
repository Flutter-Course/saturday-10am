import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final double height;
  final Color color;
  final int numberOfOrders;
  final String name;
  ChartBar({
    @required this.height,
    @required this.color,
    @required this.name,
    @required this.numberOfOrders,
  });
  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: 'Name: $name\n#Orders: $numberOfOrders',
      textStyle: TextStyle(color: Theme.of(context).primaryColor),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          width: 2,
          color: Theme.of(context).primaryColor,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        height: height,
        width: 20,
        color: color,
      ),
    );
  }
}
