import 'package:flutter/material.dart';

class CollectingDataTitle extends StatelessWidget {
  final String data;
  CollectingDataTitle(this.data);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.05),
      child: Text(
        data,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
      ),
    );
  }
}
