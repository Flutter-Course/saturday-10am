import 'package:flutter/material.dart';

class RightArrowButton extends FlatButton {
  RightArrowButton({
    @required String child,
    @required Function onPressed,
  }) : super(
          child: Text(
            child,
            style: TextStyle(color: Colors.white),
          ),
          padding: EdgeInsets.only(right: 20),
          shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          color: Colors.black,
          onPressed: onPressed,
        );
}
