class Person {
  final int id;
  final String name, posterUrl;

  Person.fromJson(dynamic json)
      : this.id = json['id'],
        this.name = json['name'],
        this.posterUrl =
            'https://image.tmdb.org/t/p/original/${json['profile_path']}';
}
