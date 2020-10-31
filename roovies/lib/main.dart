import 'package:flutter/material.dart';
import 'package:roovies/helpers/constants.dart';
import 'package:roovies/screens/home_screen.dart';

void main() {
  runApp(MyApp());
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
            color: Colors.grey[700],
          ),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
    );
  }
}
