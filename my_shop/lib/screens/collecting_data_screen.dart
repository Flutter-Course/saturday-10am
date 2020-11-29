import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_shop/widgets/collecting_data_screen/collecting_first.dart';
import 'package:page_indicator/page_indicator.dart';

import 'auth_screen.dart';

class CollectingDataScreen extends StatefulWidget {
  static const String routeName = '/collecting';
  @override
  _CollectingDataScreenState createState() => _CollectingDataScreenState();
}

class _CollectingDataScreenState extends State<CollectingDataScreen> {
  PageController controller;
  @override
  void initState() {
    super.initState();
    controller = PageController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double heigh = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    Future<bool> logout() async {
      bool action = await showDialog(
        context: context,
        child: AlertDialog(
          title: Text('Are you sure?'),
          content: Text(
              'By logging out you will be asked the same information in your next login'),
          actions: [
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text(
                'Logout',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ),
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.black),
              ),
            )
          ],
        ),
      );
      return action;
    }

    return WillPopScope(
      onWillPop: () async {
        bool action = await logout();
        if (action == true) {
          FirebaseAuth.instance.signOut();
          Navigator.of(context).pushReplacementNamed(AuthScreen.routeName);
        }
        return false;
      },
      child: Scaffold(
        body: Container(
          height: heigh,
          width: width,
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(20, 30, 20, 5),
            child: Container(
              height: heigh - MediaQuery.of(context).padding.top - 20,
              width: width,
              child: PageIndicatorContainer(
                length: 2,
                indicatorColor: Colors.grey,
                indicatorSelectorColor: Colors.black,
                padding: EdgeInsets.only(bottom: 30),
                shape: IndicatorShape.roundRectangleShape(
                    size: Size(20, 5), cornerSize: Size.square(20)),
                child: PageView(
                  controller: controller,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    CollectingFirst(logout),
                    Container(
                      color: Colors.green,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
