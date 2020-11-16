import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Roovies',
              style: TextStyle(fontFamily: 'Pacifico', fontSize: 30)),
          CircularProgressIndicator(),
        ],
      ),
    );
  }
}
