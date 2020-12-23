import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_shop/screens/auth_screen.dart';
import 'package:my_shop/screens/collecting_data_screen.dart';
import 'package:my_shop/screens/home_screen.dart';
import 'package:my_shop/screens/splash_screen.dart';
import 'package:my_shop/screens/vendor_screens/add_product_screen.dart';
import 'package:my_shop/screens/vendor_screens/products_screen.dart';
import 'package:provider/provider.dart';
import 'package:my_shop/providers/user_provider.dart';
import 'package:my_shop/screens/transit_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: MaterialApp(
        title: 'MyShop',
        theme: ThemeData(
          primaryColor: Colors.white,
          accentColor: Colors.black,
          appBarTheme: AppBarTheme(
            centerTitle: true,
          ),
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
                  return TransitScreen();
                } else {
                  return AuthScreen();
                }
              }
            }),
        routes: {
          AuthScreen.routeName: (context) => AuthScreen(),
          HomeScreen.routeName: (context) => HomeScreen(),
          CollectingDataScreen.routeName: (context) => CollectingDataScreen(),
          TransitScreen.routeName: (context) => TransitScreen(),
          ProductsScreen.routeName: (context) => ProductsScreen(),
          AddProductScreen.routeName: (context) => AddProductScreen(),
        },
      ),
    );
  }
}
