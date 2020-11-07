import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class MovieRatingBar extends StatelessWidget {
  final double rating;
  MovieRatingBar(this.rating);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '$rating',
          style: TextStyle(color: Colors.white),
        ),
        SizedBox(
          width: 10,
        ),
        RatingBar(
          initialRating: rating / 2,
          allowHalfRating: true,
          ignoreGestures: true,
          itemSize: 20,
          itemBuilder: (context, index) => Icon(
            Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: null,
        )
      ],
    );
  }
}
