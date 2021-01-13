import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_shop/providers/user_provider.dart';
import 'package:my_shop/screens/home_screen.dart';
import 'package:my_shop/widgets/collecting_data_widgets/collecting_data_one.dart';
import 'package:my_shop/widgets/collecting_data_widgets/collecting_data_two.dart';
import 'package:page_indicator/page_indicator.dart';
import 'package:provider/provider.dart';

class CollectingDataScreen extends StatefulWidget {
  @override
  _CollectingDataScreenState createState() => _CollectingDataScreenState();
}

class _CollectingDataScreenState extends State<CollectingDataScreen> {
  PageController pageController;
  File image;
  String username, mobileNumber;
  int index;
  bool loading;

  @override
  void initState() {
    super.initState();
    index = 0;
    loading = false;
    pageController = PageController();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void nextPage(File image, String userName, String mobileNumber) {
    setState(() {
      this.image = image;
      this.username = userName;
      this.mobileNumber = mobileNumber;
      index++;
    });
    pageController.nextPage(
      duration: Duration(seconds: 1),
      curve: Curves.decelerate,
    );
  }

  void previousPage() {
    setState(() {
      index--;
    });
    pageController.previousPage(
      duration: Duration(seconds: 1),
      curve: Curves.decelerate,
    );
  }

  void submit(LatLng position, String address) async {
    setState(() {
      loading = true;
    });
    bool noError = await Provider.of<UserProvider>(context, listen: false)
        .completeProfile(username, mobileNumber, address, position, image);
    if (noError) {
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    } else {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            physics:
                index == 0 ? ScrollPhysics() : NeverScrollableScrollPhysics(),
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: PageIndicatorContainer(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height * 0.1 / 2 + 8),
                length: 2,
                indicatorSelectorColor: Colors.black,
                indicatorColor: Colors.grey,
                shape: IndicatorShape.roundRectangleShape(
                  size: Size(20, 5),
                  cornerSize: Size.square(20),
                ),
                child: PageView(
                  controller: pageController,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    CollectingDataOne(nextPage),
                    CollectingDataTwo(previousPage, submit),
                  ],
                ),
              ),
            ),
          ),
          if (loading)
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.black45,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}
