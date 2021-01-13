import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:my_shop/models/review.dart';

class ReviewWidget extends StatelessWidget {
  final Review review;

  ReviewWidget(this.review);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 5),
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(review.userPhoto),
        ),
        title: Text(
          review.userName,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(review.text),
      ),
    );
  }
}
