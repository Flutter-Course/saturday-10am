import 'package:flutter/material.dart';
import 'package:roovies/widgets/movie_info_item.dart';

class MovieInfo extends StatelessWidget {
  final String budget, duration, releaseDate;
  MovieInfo(this.budget, this.duration, this.releaseDate);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MovieInfoItem('Budget', budget),
          MovieInfoItem('Duration', duration),
          MovieInfoItem('Release Date', releaseDate),
        ],
      ),
    );
  }
}
