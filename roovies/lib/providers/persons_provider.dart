import 'package:flutter/material.dart';
import 'package:roovies/models/person.dart';
import 'package:roovies/models/tmdb_handler.dart';

class PersonsProvider with ChangeNotifier {
  List<Person> trendingPersons;

  Future<bool> fetchTrendingPersons() async {
    try {
      trendingPersons = await TMDBHandler.instance.getTrendingPersons();
      return true;
    } catch (error) {
      return false;
    }
  }
}
