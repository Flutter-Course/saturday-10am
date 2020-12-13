import 'package:flutter/material.dart';
import 'package:my_shop/providers/user_provider.dart';
import 'package:my_shop/screens/collecting_data_screen.dart';
import 'package:my_shop/screens/home_screen.dart';
import 'package:my_shop/screens/splash_screen.dart';
import 'package:provider/provider.dart';

class TransitScreen extends StatelessWidget {
  static const routeName = '/transit';
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future:
          Provider.of<UserProvider>(context, listen: false).profileComplete(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SplashScreen();
        } else if (snapshot.data == true) {
          return HomeScreen();
        } else {
          return CollectingDataScreen();
        }
      },
    );
  }
}
