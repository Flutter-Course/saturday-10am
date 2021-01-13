import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_shop/providers/cart.dart';
import 'package:my_shop/providers/product_options.dart';
import 'package:my_shop/providers/products_provider.dart';
import 'package:my_shop/providers/user_provider.dart';
import 'package:my_shop/screens/add_product_screen.dart';
import 'package:my_shop/screens/auth_screen.dart';
import 'package:my_shop/screens/cart_screen.dart';
import 'package:my_shop/screens/checkout_screen.dart';
import 'package:my_shop/screens/filter_screen.dart';
import 'package:my_shop/screens/home_screen.dart';
import 'package:my_shop/screens/splash_screen.dart';
import 'package:my_shop/screens/transit_screen.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => ProductOptionsProvider()),
        ChangeNotifierProvider(create: (context) => ProductsProvider()),
        ChangeNotifierProvider(create: (context) => Cart()),
      ],
      child: MaterialApp(
        title: 'MyShop',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.white,
          accentColor: Colors.black,
          fontFamily: 'MontserratAlternates',
          visualDensity: VisualDensity.adaptivePlatformDensity,
          appBarTheme: AppBarTheme(
            centerTitle: true,
          ),
        ),
        home: FutureBuilder(
            future: _initialization,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SplashScreen();
              } else {
                if (FirebaseAuth.instance.currentUser != null) {
                  return TransitScreen();
                }
                return AuthScreen();
              }
            }),
        routes: {
          AuthScreen.routeName: (context) => AuthScreen(),
          HomeScreen.routeName: (context) => HomeScreen(),
          TransitScreen.routeName: (context) => TransitScreen(),
          AddProductScreen.routeName: (context) => AddProductScreen(),
          FilterScreen.routeName: (context) => FilterScreen(),
          CartScreen.routeName: (context) => CartScreen(),
          CheckoutScreen.routeName: (context) => CheckoutScreen(),
        },
      ),
    );
  }
}
