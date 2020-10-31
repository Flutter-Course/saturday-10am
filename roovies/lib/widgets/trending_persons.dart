import 'package:flutter/material.dart';
import 'package:roovies/widgets/persons_list.dart';

class TrendingPerons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10, left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Trending Persons',
            style: Theme.of(context).textTheme.headline6,
          ),
          SizedBox(
            height: 10,
          ),
          PersonsList()
        ],
      ),
    );
  }
}
