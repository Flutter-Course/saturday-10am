import 'package:flutter/material.dart';

class HeroItem extends StatelessWidget {
  final Color color;
  final String name;
  HeroItem(this.color, this.name);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 10,
          width: 10,
          color: color,
        ),
        Text(name),
      ],
    );
  }
}
