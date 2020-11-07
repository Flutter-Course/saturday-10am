class Movie {
  final String title, backPosterUrl, posterUrl;
  final double rating;
  final int id;

  Movie.fromJson(dynamic json)
      : this.title = json['title'],
        this.id = json['id'],
        this.rating = json['vote_average'].toDouble(),
        this.backPosterUrl =
            'https://image.tmdb.org/t/p/original/${json['backdrop_path']}',
        this.posterUrl =
            'https://image.tmdb.org/t/p/original/${json['poster_path']}';
}
