import 'dart:ui';

import 'package:flutter/material.dart';

class EditProductField extends StatelessWidget {
  final String title, hint, initialValue;
  final Function onChanged;
  final bool isNumber, isMultiLine;

  EditProductField(this.title, this.hint, this.onChanged, this.initialValue,
      {this.isNumber = false, this.isMultiLine = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      keyboardType: isNumber
          ? TextInputType.number
          : isMultiLine
              ? TextInputType.multiline
              : TextInputType.text,
      maxLines: isMultiLine ? 5 : 1,
      minLines: 1,
      decoration: InputDecoration(
          labelText: title,
          labelStyle: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          hintText: hint,
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
              width: 2,
            ),
          )),
      onChanged: onChanged,
    );
  }
}
