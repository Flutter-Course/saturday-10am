import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function onPressed;
  DrawerItem(this.title, this.icon, this.onPressed);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      trailing: Icon(icon, color: Colors.black),
      onTap: onPressed,
    );
  }
}
