class MovieDetails {
  final String videoUrl, overview, releaseDate;
  final int budget, duration;

  MovieDetails.fromJson(dynamic json)
      : this.videoUrl = '',
        this.releaseDate = json['release_date'],
        this.budget = json['budget'],
        this.duration = json['runtime'],
        this.overview = json['overview'];
}
