import 'package:flutter/material.dart';

class MovieGenreItem extends StatelessWidget {
  final String genreName;
  MovieGenreItem(this.genreName);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 5, bottom: 5),
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Colors.white),
      ),
      child: Text(
        genreName,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
