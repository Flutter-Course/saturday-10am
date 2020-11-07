import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:roovies/helpers/constants.dart';
import 'package:roovies/providers/genres_provider.dart';
import 'package:roovies/providers/movies_provider.dart';
import 'package:roovies/providers/persons_provider.dart';
import 'package:roovies/screens/home_screen.dart';
import 'package:roovies/screens/movie_details_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MoviesProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => GenresProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => PersonsProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Roovies',
        theme: ThemeData(
          primarySwatch: Constants.color,
          accentColor: Color.fromRGBO(245, 195, 15, 1),
          scaffoldBackgroundColor: Constants.color,
          fontFamily: 'Poppins',
          textTheme: TextTheme(
            headline6: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey[700],
            ),
          ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomeScreen(),
        routes: {
          HomeScreen.routeName: (context) => HomeScreen(),
          MovieDetailsScreen.routeName: (context) => MovieDetailsScreen(),
        },
      ),
    );
  }
}
