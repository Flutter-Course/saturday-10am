import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:roovies/models/firebase_handler.dart';
import 'package:roovies/models/movie.dart';
import 'package:roovies/models/movie_details.dart';
import 'package:roovies/models/tmdb_handler.dart';
import 'package:roovies/models/user.dart';

class MoviesProvider with ChangeNotifier {
  List<Movie> nowPlayingMovies;
  List<Movie> moviesByGenre;
  List<Movie> trendingMovies;
  List<Movie> favorites = [];
  Future<bool> fetchNowPlayingMovies() async {
    try {
      nowPlayingMovies = await TMDBHandler.instance.getNowPlaying();
      return true;
    } catch (error) {
      return false;
    }
  }

  Future<bool> fetchMoviesByGenre(int genreId) async {
    try {
      moviesByGenre = await TMDBHandler.instance.getMoviesByGenreID(genreId);
      return true;
    } catch (error) {
      return false;
    }
  }

  Future<bool> fetchTrendingMovies() async {
    try {
      trendingMovies = await TMDBHandler.instance.getTrendingMovies();
      return true;
    } catch (error) {
      return false;
    }
  }

  Future<MovieDetails> fetchMovieDetails(int movieId) async {
    try {
      MovieDetails movieDetails =
          await TMDBHandler.instance.getMovieDetails(movieId);
      return movieDetails;
    } catch (error) {
      return null;
    }
  }

  Future<String> fetchVideoByMovieId(int movieId) async {
    try {
      return await TMDBHandler.instance.getVideoByMoviId(movieId);
    } catch (error) {
      return null;
    }
  }

  void toggleFavoriteStatus(Movie movie, User user) async {
    try {
      if (isFavorite(movie.id)) {
        await FireBaseHandler.instance.deleteFavorite(movie, user);
        favorites.removeWhere((element) => element.id == movie.id);
      } else {
        await FireBaseHandler.instance.addFavorite(movie, user);
        favorites.add(movie);
      }

      notifyListeners();
    } on DioError catch (error) {
      print(error.response.data);
    }
  }

  bool isFavorite(int movieId) {
    return favorites.any((element) => element.id == movieId);
  }

  Future<bool> fetchFavorites(User user) async {
    try {
      favorites = await FireBaseHandler.instance.favorites(user);
      return true;
    } catch (error) {
      return false;
    }
  }
}
