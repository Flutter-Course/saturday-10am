import 'package:flutter/material.dart';

class MovieInfoItem extends StatelessWidget {
  final String title, data;
  MovieInfoItem(this.title, this.data);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headline6.copyWith(
                fontWeight: FontWeight.normal,
                fontSize: 14,
              ),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          data,
          style: TextStyle(color: Theme.of(context).accentColor),
        ),
      ],
    );
  }
}
