import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:roovies/models/movie.dart';
import 'package:roovies/models/movie_details.dart';
import 'package:roovies/providers/movies_provider.dart';
import 'package:roovies/widgets/movie_rating_bar.dart';
import 'package:sliver_fab/sliver_fab.dart';

class MovieDetailsScreen extends StatefulWidget {
  static const String routeName = '/movie-details';

  @override
  _MovieDetailsScreenState createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  MovieDetails movieDetails;
  Movie movie;
  bool firstRun;
  @override
  void initState() {
    super.initState();
    firstRun = true;
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (firstRun) {
      movie = ModalRoute.of(context).settings.arguments as Movie;
      movieDetails = await Provider.of<MoviesProvider>(context, listen: false)
          .fetchMovieDetails(movie.id);
      // print(movieDetails.overview);
      setState(() {
        firstRun = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (firstRun)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : (movieDetails != null)
              ? SliverFab(
                  slivers: [
                    SliverAppBar(
                      pinned: true,
                      expandedHeight: MediaQuery.of(context).size.height * 0.4,
                      flexibleSpace: FlexibleSpaceBar(
                        title: Padding(
                          padding: EdgeInsets.only(right: 75),
                          child: Text(
                            movie.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        background: Stack(
                          children: [
                            Container(
                              width: double.infinity,
                              height: double.infinity,
                              child: Image.network(
                                movie.backPosterUrl,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Theme.of(context).primaryColor,
                                    Theme.of(context)
                                        .primaryColor
                                        .withOpacity(0),
                                  ],
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SliverPadding(
                      padding: EdgeInsets.all(8.0),
                      sliver: SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            MovieRatingBar(movie.rating),
                          ],
                        ),
                      ),
                    )
                  ],
                  floatingPosition: FloatingPosition(right: 20),
                  expandedHeight: MediaQuery.of(context).size.height * 0.4,
                  floatingWidget: FloatingActionButton(
                    onPressed: () {},
                    child: Icon(Icons.play_arrow),
                  ),
                )
              : Center(
                  child: Text('Error has occured'),
                ),
    );
  }
}
