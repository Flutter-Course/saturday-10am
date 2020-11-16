import 'package:flutter/material.dart';
import 'package:roovies/models/genre.dart';
import 'package:roovies/widgets/movie_genre_item.dart';

class MovieGenres extends StatelessWidget {
  final List<Genre> genres;
  MovieGenres(this.genres);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Genres',
            style: Theme.of(context).textTheme.headline6,
          ),
          Wrap(
            children: genres.map((genre) {
              return MovieGenreItem(genre.name);
            }).toList(),
          ),
        ],
      ),
    );
  }
}
