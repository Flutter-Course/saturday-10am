import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_shop/providers/user_provider.dart';
import 'package:my_shop/widgets/collecting_data_screen/collecting_first.dart';
import 'package:my_shop/widgets/collecting_data_screen/collecting_second.dart';
import 'package:page_indicator/page_indicator.dart';
import 'package:provider/provider.dart';
import 'package:my_shop/screens/transit_screen.dart';

import 'auth_screen.dart';

class CollectingDataScreen extends StatefulWidget {
  static const String routeName = '/collecting';
  @override
  _CollectingDataScreenState createState() => _CollectingDataScreenState();
}

class _CollectingDataScreenState extends State<CollectingDataScreen> {
  PageController controller;
  LatLng currentCoordinates;
  String currentAddress, userName, mobileNumber;
  File pickedImage;
  int index;
  bool loading;
  @override
  void initState() {
    super.initState();
    controller = PageController();
    index = 0;
    loading = false;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void submit(LatLng pos, String address) async {
    setState(() {
      currentCoordinates = pos;
      currentAddress = address;
      loading = true;
    });

    bool noError = await Provider.of<UserProvider>(context, listen: false)
        .updateProfile(pickedImage, userName, mobileNumber, currentCoordinates,
            currentAddress);
    if (!noError) {
      setState(() {
        loading = false;
      });
      showDialog(
        context: context,
        child: AlertDialog(
          title: Text('Error has occurred'),
          content: Text('Please try again later.'),
          actions: [
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Ok'),
            ),
          ],
        ),
      );
    } else {
      Navigator.of(context).pushReplacementNamed(TransitScreen.routeName);
    }
  }

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

  void nextPage(File image, String userName, String mobileNumber) {
    setState(() {
      this.pickedImage = image;
      this.userName = userName;
      this.mobileNumber = mobileNumber;
      index++;
    });
    controller.nextPage(
        duration: Duration(seconds: 1), curve: Curves.decelerate);
  }

  void prevPage() {
    setState(() {
      index--;
    });
    controller.previousPage(
        duration: Duration(seconds: 1), curve: Curves.decelerate);
  }

  @override
  Widget build(BuildContext context) {
    double heigh = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

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
        body: Stack(
          children: [
            Container(
              height: heigh,
              width: width,
              child: SingleChildScrollView(
                physics: (index == 1)
                    ? NeverScrollableScrollPhysics()
                    : ScrollPhysics(),
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
                        CollectingFirst(logout, nextPage),
                        CollectingSecond(prevPage, submit),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            if (loading)
              Container(
                height: heigh,
                width: width,
                color: Colors.black38,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
