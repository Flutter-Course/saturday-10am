import 'package:flutter/material.dart';

class StickyHeaderHead extends StatelessWidget {
  final String date;
  StickyHeaderHead(this.date);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      margin: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.04,
      ).add(
        EdgeInsets.only(bottom: 16),
      ),
      color: Theme.of(context).primaryColor,
      child: Container(
        padding: EdgeInsets.all(16.0),
        width: double.infinity,
        child: Text(
          date,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
