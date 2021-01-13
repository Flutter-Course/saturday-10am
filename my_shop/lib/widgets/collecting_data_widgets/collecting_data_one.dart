import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_shop/screens/auth_screen.dart';
import 'package:my_shop/widgets/collecting_data_widgets/collecting_data_title.dart';
import 'file:///D:/Workspace/flutter%20projects/Friday/my_shop/lib/widgets/misc/image_frame.dart';
import 'package:my_shop/widgets/misc/arrow_button.dart';

class CollectingDataOne extends StatefulWidget {
  final Function nextPage;

  CollectingDataOne(this.nextPage);

  @override
  _CollectingDataOneState createState() => _CollectingDataOneState();
}

class _CollectingDataOneState extends State<CollectingDataOne> {
  File image;
  String userName, mobileNumber;

  void getImage(bool fromGallery) async {
    ImagePicker picker = ImagePicker();
    final pickedFile = await picker.getImage(
        source: (fromGallery) ? ImageSource.gallery : ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
      });
    }
  }

  bool validate() {
    return image != null &&
        userName != null &&
        userName.length >= 3 &&
        mobileNumber != null &&
        mobileNumber.length == 11 &&
        mobileNumber.startsWith('01');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      height: double.infinity,
      width: double.infinity,
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 9,
              child: Column(
                children: [
                  CollectingDataTitle(
                      'Few steps left to complete your profile.'),
                  ImageFrame.fromFile(image),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RaisedButton.icon(
                        color: Colors.black,
                        icon: Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                        ),
                        label: Text(
                          'Camera',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          getImage(false);
                        },
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      RaisedButton.icon(
                        color: Colors.black,
                        icon: Icon(Icons.photo_library, color: Colors.white),
                        label: Text(
                          'Gallery',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          getImage(true);
                        },
                      ),
                    ],
                  ),
                  TextFormField(
                    onChanged: (value) {
                      setState(() {
                        userName = value;
                      });
                    },
                    decoration: InputDecoration(
                      labelStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          width: 2,
                          color: Colors.black,
                        ),
                      ),
                      labelText: 'Username',
                      hintText: 'Ex. Muhammed Aly',
                    ),
                  ),
                  TextFormField(
                    onChanged: (value) {
                      setState(() {
                        mobileNumber = value;
                      });
                    },
                    decoration: InputDecoration(
                      labelStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          width: 2,
                          color: Colors.black,
                        ),
                      ),
                      labelText: 'Mobile Number',
                      hintText: '01xxxxxxxxx',
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ArrowButton.left(
                    title: 'Logout',
                    onPressed: () async {
                      bool logout = await showDialog(
                        context: context,
                        child: AlertDialog(
                          title: Text('Are you sure?'),
                          content: Text(
                            'By logging out you will be asked the same questions the next time you login.',
                          ),
                          actions: [
                            FlatButton(
                              child: Text(
                                'Cancel',
                                style: TextStyle(color: Colors.red),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop(false);
                              },
                            ),
                            RaisedButton(
                              color: Colors.black,
                              child: Text(
                                'Logout',
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop(true);
                              },
                            ),
                          ],
                        ),
                      );
                      if (logout) {
                        FirebaseAuth.instance.signOut();
                        Navigator.of(context)
                            .pushReplacementNamed(AuthScreen.routeName);
                      }
                    },
                  ),
                  ArrowButton.right(
                      title: 'Next',
                      onPressed: () {
                        if (validate()) {
                          widget.nextPage(image, userName, mobileNumber);
                        } else {
                          showDialog(
                            context: context,
                            child: AlertDialog(
                              title: Text('Invalid or Missing Data'),
                              content: Text(
                                  'Please make sure that you have picked an image, entered a username consists of at least 3 characters and a valid mobile number.'),
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
                        }
                      }),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
