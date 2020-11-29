import 'package:flutter/material.dart';

class LeftArrowButton extends FlatButton {
  LeftArrowButton({
    @required String child,
    @required Function onPressed,
  }) : super(
          child: Text(
            child,
            style: TextStyle(color: Colors.white),
          ),
          padding: EdgeInsets.only(left: 20),
          shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              bottomLeft: Radius.circular(30),
            ),
          ),
          color: Colors.black,
          onPressed: onPressed,
        );
}
