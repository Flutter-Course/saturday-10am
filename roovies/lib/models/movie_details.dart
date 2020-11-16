import 'package:roovies/models/genre.dart';

class MovieDetails {
  final String videoUrl, overview, releaseDate;
  final int budget, duration;
  final List<Genre> genres;
  MovieDetails.fromJson(dynamic json)
      : this.videoUrl = '',
        this.releaseDate = json['release_date'],
        this.budget = json['budget'],
        this.duration = json['runtime'],
        this.overview = json['overview'],
        this.genres = (json['genres'] as List)
            .map((genre) => Genre.fromJson(genre))
            .toList();
}
