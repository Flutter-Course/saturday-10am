import 'dart:ui';

import 'package:flutter/material.dart';

class ArrowButton extends RaisedButton {
  ArrowButton.left({@required String title, @required Function onPressed})
      : super(
            padding: EdgeInsets.only(left: 20),
            color: Colors.black,
            shape: BeveledRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
            ),
            child: Text(
              title,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onPressed: onPressed);

  ArrowButton.right({@required String title, @required Function onPressed})
      : super(
            padding: EdgeInsets.only(right: 20),
            color: Colors.black,
            shape: BeveledRectangleBorder(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Text(
              title,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onPressed: onPressed);
}
