import 'package:flutter/material.dart';
import 'package:roovies/widgets/movies_list.dart';

class TrendingMovies extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10, left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Trending Movies',
            style: Theme.of(context).textTheme.headline6,
          ),
          SizedBox(
            height: 10,
          ),
          MoviesList(),
        ],
      ),
    );
  }
}
