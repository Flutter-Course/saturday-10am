import 'package:flutter/material.dart';
import 'package:roovies/widgets/genres_list.dart';
import 'package:roovies/widgets/now_playing.dart';
import 'package:roovies/widgets/trending_movies.dart';
import 'package:roovies/widgets/trending_persons.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.dehaze),
          onPressed: () {},
        ),
        title: Text('Roovies'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        children: [
          NowPlaying(),
          GenresList(),
          TrendingPerons(),
          TrendingMovies(),
        ],
      ),
    );
  }
}
