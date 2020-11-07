import 'package:flutter/material.dart';
import 'package:roovies/models/genre.dart';
import 'package:roovies/models/tmdb_handler.dart';

class GenresProvider with ChangeNotifier {
  List<Genre> genres;

  Future<bool> fetchGenres() async {
    try {
      genres = await TMDBHandler.instance.getGenres();
      return true;
    } catch (error) {
      return false;
    }
  }
}
