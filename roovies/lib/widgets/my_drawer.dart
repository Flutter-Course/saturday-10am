import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:roovies/providers/user_provider.dart';
import 'package:roovies/screens/authentication_screen.dart';
import 'package:roovies/screens/home_screen.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Theme.of(context).primaryColor,
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.only(
                top: 20,
                bottom: 20,
                left: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome',
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    context.watch<UserProvider>().currentUser.email,
                    style: TextStyle(color: Theme.of(context).accentColor),
                  ),
                ],
              ),
            ),
            Divider(
              color: Theme.of(context).accentColor,
              thickness: 2,
            ),
            Card(
              elevation: 8,
              margin: EdgeInsets.all(8),
              shadowColor: Theme.of(context).accentColor,
              color: Theme.of(context).accentColor,
              child: ListTile(
                onTap: () {
                  bool isHome = (ModalRoute.of(context).settings.name ==
                      HomeScreen.routeName);
                  if (isHome) {
                    Navigator.of(context).pop();
                  } else {
                    Navigator.of(context)
                        .pushReplacementNamed(HomeScreen.routeName);
                  }
                },
                title: Text('Home'),
                trailing: Icon(Icons.home),
              ),
            ),
            Card(
              elevation: 8,
              margin: EdgeInsets.all(8),
              shadowColor: Theme.of(context).accentColor,
              color: Theme.of(context).accentColor,
              child: ListTile(
                onTap: () {},
                title: Text('Favorites'),
                trailing: Icon(Icons.bookmark),
              ),
            ),
            Card(
              elevation: 8,
              margin: EdgeInsets.all(8),
              shadowColor: Theme.of(context).accentColor,
              color: Theme.of(context).accentColor,
              child: ListTile(
                onTap: () {
                  Provider.of<UserProvider>(context, listen: false)
                      .cleareUserData();
                  Navigator.of(context)
                      .pushReplacementNamed(AuthenticationScreen.routeName);
                },
                title: Text('Logout'),
                trailing: Icon(Icons.exit_to_app),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
