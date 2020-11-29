import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_shop/screens/auth_screen.dart';
import 'package:my_shop/screens/collecting_data_screen.dart';
import 'package:my_shop/screens/home_screen.dart';
import 'package:my_shop/screens/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyShop',
      theme: ThemeData(
        primaryColor: Colors.white,
        accentColor: Colors.black,
        fontFamily: 'MontserratAlternates',
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FutureBuilder(
          future: _initialization,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return SplashScreen();
            } else {
              if (FirebaseAuth.instance.currentUser != null) {
                print(FirebaseAuth.instance.currentUser.email);
                return CollectingDataScreen();
              } else {
                return AuthScreen();
              }
            }
          }),
      routes: {
        AuthScreen.routeName: (context) => AuthScreen(),
        HomeScreen.routeName: (context) => HomeScreen(),
        CollectingDataScreen.routeName: (context) => CollectingDataScreen(),
      },
    );
  }
}
