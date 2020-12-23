import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_shop/providers/user_provider.dart';
import 'package:my_shop/widgets/misc/my_drawer.dart';
import 'package:provider/provider.dart';

import 'auth_screen.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/home';
  @override
  Widget build(BuildContext context) {
    print(Provider.of<UserProvider>(context).currentUser.email);
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text('My Shop'),
        centerTitle: true,
      ),
      body: RaisedButton(
        child: Text('Logout'),
        onPressed: () {
          FirebaseAuth.instance.signOut();
          Navigator.of(context).pushReplacementNamed(AuthScreen.routeName);
        },
      ),
    );
  }
}
