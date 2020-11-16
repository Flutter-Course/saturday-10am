import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:roovies/helpers/constants.dart';
import 'package:roovies/providers/genres_provider.dart';
import 'package:roovies/providers/movies_provider.dart';
import 'package:roovies/providers/persons_provider.dart';
import 'package:roovies/providers/user_provider.dart';
import 'package:roovies/screens/authentication_screen.dart';
import 'package:roovies/screens/home_screen.dart';
import 'package:roovies/screens/movie_details_screen.dart';
import 'package:roovies/screens/splash_screen.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => MoviesProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => GenresProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => PersonsProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
    ),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
            color: Colors.blueGrey,
          ),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FutureBuilder(
        future: Provider.of<UserProvider>(context, listen: false).isLoggedIn(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SplashScreen();
          } else if (snapshot.data == true) {
            return HomeScreen();
          } else {
            print(snapshot.error);
            return AuthenticationScreen();
          }
        },
      ),
      routes: {
        HomeScreen.routeName: (context) => HomeScreen(),
        MovieDetailsScreen.routeName: (context) => MovieDetailsScreen(),
        AuthenticationScreen.routeName: (context) => AuthenticationScreen(),
      },
    );
  }
}
