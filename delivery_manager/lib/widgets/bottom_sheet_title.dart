import 'package:flutter/material.dart';

class BottomSheetTitle extends StatelessWidget {
  final String text;
  BottomSheetTitle(this.text);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
