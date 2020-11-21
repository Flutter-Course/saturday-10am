import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:roovies/models/user.dart';
import 'package:roovies/providers/movies_provider.dart';
import 'package:roovies/providers/user_provider.dart';
import 'package:roovies/screens/authentication_screen.dart';
import 'package:roovies/screens/movie_details_screen.dart';

class MoviesList extends StatefulWidget {
  final int genreId;
  MoviesList.byGenre(this.genreId);
  MoviesList.byTrending() : genreId = null;

  @override
  _MoviesListState createState() => _MoviesListState();
}

class _MoviesListState extends State<MoviesList> {
  bool firstRun, successful;

  @override
  void initState() {
    super.initState();
    firstRun = true;
    successful = false;
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (firstRun) {
      bool done;
      if (widget.genreId != null) {
        done = await Provider.of<MoviesProvider>(context, listen: false)
            .fetchMoviesByGenre(widget.genreId);
      } else {
        done = await Provider.of<MoviesProvider>(context, listen: false)
            .fetchTrendingMovies();
      }
      if (mounted) {
        setState(() {
          firstRun = false;
          successful = done;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.45 - 48,
      width: MediaQuery.of(context).size.width,
      child: (firstRun)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : (successful)
              ? ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemExtent: 140,
                  itemCount: (widget.genreId != null)
                      ? Provider.of<MoviesProvider>(context)
                          .moviesByGenre
                          .length
                      : Provider.of<MoviesProvider>(context)
                          .trendingMovies
                          .length,
                  itemBuilder: (context, index) {
                    final movie = (widget.genreId != null)
                        ? Provider.of<MoviesProvider>(context)
                            .moviesByGenre[index]
                        : Provider.of<MoviesProvider>(context)
                            .trendingMovies[index];

                    bool isFav = Provider.of<MoviesProvider>(context)
                        .isFavorite(movie.id);
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Stack(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                  MovieDetailsScreen.routeName,
                                  arguments: movie);
                            },
                            child: Column(
                              children: [
                                Expanded(
                                  flex: 7,
                                  child: Image.network(
                                    movie.posterUrl,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Center(
                                    child: Text(
                                      movie.title,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '${movie.rating}',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      RatingBar(
                                        allowHalfRating: true,
                                        ignoreGestures: true,
                                        itemCount: 5,
                                        initialRating: movie.rating / 2,
                                        itemPadding: EdgeInsets.all(2),
                                        itemSize: 10,
                                        itemBuilder: (context, _) => Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        onRatingUpdate: null,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            right: 5,
                            top: 5,
                            child: Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                gradient: RadialGradient(
                                  colors: [
                                    Theme.of(context).primaryColor,
                                    Theme.of(context)
                                        .primaryColor
                                        .withOpacity(0),
                                  ],
                                ),
                              ),
                              child: InkWell(
                                onTap: () async {
                                  bool done = await context
                                      .read<UserProvider>()
                                      .refreshTokenIfNecessary();
                                  if (done) {
                                    User user = context
                                        .read<UserProvider>()
                                        .currentUser;
                                    Provider.of<MoviesProvider>(context,
                                            listen: false)
                                        .toggleFavoriteStatus(movie, user);
                                  } else {
                                    await showDialog(
                                      context: context,
                                      child: AlertDialog(
                                        title: Text('Error has occurred'),
                                        content:
                                            Text('You have to sign in again.'),
                                        actions: [
                                          FlatButton(
                                            child: Text('OK'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      ),
                                    );
                                    Navigator.of(context).pushNamed(
                                        AuthenticationScreen.routeName);
                                  }
                                },
                                child: Icon(
                                  (isFav)
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: Theme.of(context).accentColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                )
              : Center(
                  child: Text(
                    'Error has occurred',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
    );
  }
}
