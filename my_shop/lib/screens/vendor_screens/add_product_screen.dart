import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddProductScreen extends StatefulWidget {
  static const routeName = '/add-product';
  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  List<File> images;
  String gender, age, name, description, category;
  double price;
  @override
  void initState() {
    super.initState();
    images = [];
  }

  Future<int> cameraOrGallery() async {
    return await showDialog(
      context: context,
      child: SimpleDialog(
        title: Text('Image Source'),
        children: [
          SimpleDialogOption(
            onPressed: () {
              Navigator.of(context).pop(1);
            },
            child: Row(
              children: [
                Icon(Icons.camera_alt),
                SizedBox(
                  width: 5,
                ),
                Text('From Camera'),
              ],
            ),
          ),
          SimpleDialogOption(
            onPressed: () {
              Navigator.of(context).pop(2);
            },
            child: Row(
              children: [
                Icon(Icons.photo_library),
                SizedBox(
                  width: 5,
                ),
                Text('From Gallery'),
              ],
            ),
          ),
          SimpleDialogOption(
            onPressed: () {
              Navigator.of(context).pop(-1);
            },
            child: Row(
              children: [
                Icon(Icons.cancel),
                SizedBox(
                  width: 5,
                ),
                Text('Canel'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void getImage() async {
    int option = await cameraOrGallery();

    ImagePicker picker = ImagePicker();
    if (option != -1) {
      final pickedImage = await picker.getImage(
          source: option == 1 ? ImageSource.camera : ImageSource.gallery);
      if (pickedImage != null) {
        setState(() {
          images.add(File(pickedImage.path));
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pick product images',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              'Pick good images so you can attract more customers.',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5),
              height: MediaQuery.of(context).size.height * 0.2,
              width: double.infinity,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemExtent: MediaQuery.of(context).size.width * 0.4,
                itemCount: images.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return InkWell(
                      onTap: () {
                        getImage();
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        elevation: 8,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add),
                            SizedBox(
                              height: 5,
                            ),
                            Text('Add Image'),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return Stack(
                      children: [
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          elevation: 8,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              image: DecorationImage(
                                image: FileImage(images[index - 1]),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          right: 8,
                          top: 8,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                images.removeAt(index - 1);
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  gradient: RadialGradient(
                                colors: [
                                  Colors.black,
                                  Colors.black.withOpacity(0),
                                ],
                              )),
                              child: Icon(
                                Icons.remove,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
