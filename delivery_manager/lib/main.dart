import 'package:delivery_manager/screens/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode themeMode = ThemeMode.light;

  void toggleThemeMode() {
    setState(() {
      if (themeMode == ThemeMode.dark) {
        themeMode = ThemeMode.light;
      } else {
        themeMode = ThemeMode.dark;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Deliver Manager',
      theme: ThemeData(
        primaryColor: Colors.blue[900],
        accentColor: Colors.white,
      ),
      darkTheme: ThemeData(
        primaryColor: Colors.grey[900],
        accentColor: Colors.grey[600],
      ),
      themeMode: themeMode,
      home: HomeScreen(toggleThemeMode),
    );
  }
}
