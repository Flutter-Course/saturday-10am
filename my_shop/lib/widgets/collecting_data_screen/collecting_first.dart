import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_shop/widgets/collecting_data_screen/collecting_data_title.dart';
import 'package:my_shop/widgets/misc/image_frame.dart';
import 'package:my_shop/widgets/misc/left_arrow_button.dart';
import 'package:my_shop/widgets/misc/right_arrow_button.dart';

import '../../screens/auth_screen.dart';

class CollectingFirst extends StatefulWidget {
  final Function logout, nextPage;
  CollectingFirst(this.logout, this.nextPage);
  @override
  _CollectingFirstState createState() => _CollectingFirstState();
}

class _CollectingFirstState extends State<CollectingFirst> {
  File image;
  String userName, mobileNumber;
  FocusNode mobileNode;
  @override
  void initState() {
    super.initState();
    mobileNode = FocusNode();
  }

  void pickImage(bool fromGallery) async {
    ImagePicker picker = ImagePicker();
    final pickedImage = await picker.getImage(
        source: (fromGallery) ? ImageSource.gallery : ImageSource.camera);

    if (pickedImage != null) {
      setState(() {
        image = File(pickedImage.path);
      });
    }
  }

  bool validateData() {
    bool valid = true;
    if (image == null) valid = false;
    if (userName == null || userName.length < 3) valid = false;
    if (mobileNumber == null ||
        mobileNumber.length != 11 ||
        !mobileNumber.startsWith('01')) valid = false;

    return valid;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 9,
          child: Padding(
            padding: EdgeInsets.only(top: 30),
            child: Column(
              children: [
                CollectingDataTitle(
                  'Welcome,',
                  'Few steps to complete your profile.',
                ),
                SizedBox(height: 30),
                ImageFrame.fromFile(image),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RaisedButton.icon(
                      onPressed: () {
                        pickImage(true);
                      },
                      color: Colors.black,
                      icon: Icon(
                        Icons.photo_library,
                        color: Colors.white,
                      ),
                      label: Text(
                        'Gallery',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    RaisedButton.icon(
                      onPressed: () {
                        pickImage(false);
                      },
                      color: Colors.black,
                      icon: Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                      ),
                      label: Text(
                        'Camera',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  onSubmitted: (value) {
                    mobileNode.requestFocus();
                  },
                  textInputAction: TextInputAction.next,
                  onChanged: (value) {
                    setState(() {
                      userName = value;
                    });
                  },
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 2,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 2,
                      ),
                    ),
                    labelText: 'Username',
                    labelStyle: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                    hintText: 'ex. muhammed aly',
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  focusNode: mobileNode,
                  keyboardType: TextInputType.phone,
                  onChanged: (value) {
                    setState(() {
                      mobileNumber = value;
                    });
                  },
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 2,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 2,
                      ),
                    ),
                    labelText: 'Mobile Number',
                    labelStyle: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                    hintText: 'ex. 01xxxxxxxxx',
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            LeftArrowButton(
              child: 'Logout',
              onPressed: () async {
                if (await widget.logout()) {
                  Navigator.of(context)
                      .pushReplacementNamed(AuthScreen.routeName);
                }
              },
            ),
            RightArrowButton(
              child: 'Next',
              onPressed: () {
                if (validateData()) {
                  widget.nextPage(image, userName, mobileNumber);
                } else {
                  showDialog(
                    context: context,
                    child: AlertDialog(
                      title: Text('Invalid or Missing Data'),
                      content: Text(
                        'Please check that you have picked an image, and the username contains 3 characters at least and you entered valid mobile number.',
                      ),
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
              },
            )
          ],
        )),
      ],
    );
  }
}
