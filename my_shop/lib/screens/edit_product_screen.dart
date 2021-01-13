import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_shop/models/product.dart';
import 'package:my_shop/providers/user_provider.dart';
import 'package:my_shop/widgets/add_product_widgets/categories_section.dart';
import 'package:my_shop/widgets/add_product_widgets/for_who_section.dart';
import 'package:my_shop/widgets/add_product_widgets/section_title.dart';
import 'package:my_shop/widgets/edit_product_widgets/edit_product_field.dart';
import 'package:provider/provider.dart';

class EditProductScreen extends StatefulWidget {
  final Product product;

  EditProductScreen(this.product);

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  List<dynamic> images;
  String category, forWho, title, description, price;
  bool loading;

  @override
  void initState() {
    super.initState();
    loading = false;
    category = widget.product.category;
    forWho = widget.product.forWho;
    title = widget.product.title;
    description = widget.product.description;
    price = widget.product.price.toString();
    images = widget.product.photosUrls.map((e) => (e as dynamic)).toList();
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
                Icon(Icons.camera),
                SizedBox(
                  width: 5,
                ),
                Text('Camera'),
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
                Text('Gallery'),
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
                Text('Cancel'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void getImage() async {
    int choice = await cameraOrGallery();
    ImagePicker picker = ImagePicker();
    if (choice != -1) {
      final pickedFile = await picker.getImage(
          source: choice == 1 ? ImageSource.camera : ImageSource.gallery);
      if (pickedFile != null) {
        print(images.runtimeType);
        setState(() {
          images.add(File(pickedFile.path));
        });
      }
    }
  }

  void onForWhoChanged(String value) {
    setState(() {
      forWho = value;
    });
  }

  void onCategoryChanged(String value) {
    setState(() {
      category = value;
    });
  }

  void onPriceChanged(String value) {
    setState(() {
      price = value;
    });
  }

  void onDescriptionChanged(String value) {
    setState(() {
      description = value;
    });
  }

  void onTitleChanged(String value) {
    setState(() {
      title = value;
    });
  }

  void showError(String error) {
    showDialog(
      context: context,
      child: AlertDialog(
        title: Text('Invalid data'),
        content: Text(error),
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

  void tryEditProduct() async {
    try {
      if (price == null ||
          double.tryParse(price) == null ||
          double.parse(price) <= 0) {
        throw 'Price must be positive number';
      }

      if (title == null || title.length < 3) {
        throw 'Title must be at least 3 characters.';
      }

      if (description == null) {
        throw 'Please write a description so the customers can know more about your product';
      }

      if (images.length == 0) {
        throw 'Please add at leaset an image so the customers can see your product.';
      }
      setState(() {
        loading = true;
      });

      if (await Provider.of<UserProvider>(context, listen: false).editProduct(
          widget.product.id,
          title,
          description,
          forWho,
          category,
          double.parse(price),
          images,
          widget.product.available,
          widget.product.date)) {
        Navigator.of(context).pop();
      } else {
        setState(() {
          loading = false;
        });
        throw 'Coudn\'t edit the product, please try again later.';
      }
    } catch (e) {
      showError(e.toString());
    }
  }

  dynamic convertImage(dynamic image) {
    try {
      return NetworkImage(image);
    } catch (e) {
      return FileImage(image);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: Text('Edit Product'),
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SectionTitle('Pick product photos',
                    'Pick good photos so your product can attract the users.'),
                Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    scrollDirection: Axis.horizontal,
                    itemExtent: MediaQuery.of(context).size.width * 0.4,
                    itemCount: images.length + ((images.length < 5) ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == 0 && images.length < 5) {
                        return InkWell(
                          onTap: getImage,
                          child: Card(
                            color: Colors.grey,
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            margin: EdgeInsets.only(right: 5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Add Image',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      } else {
                        int i = index - ((images.length < 5) ? 1 : 0);
                        return Stack(
                          children: [
                            Card(
                              color: Colors.grey,
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              margin: EdgeInsets.only(
                                  left: index == 0 ? 0 : 5,
                                  right: index == 4 ? 0 : 5),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  image: DecorationImage(
                                    image: convertImage(images[i]),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 8,
                              right: 8,
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    images.removeAt(i);
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    gradient: RadialGradient(colors: [
                                      Colors.black,
                                      Colors.black.withOpacity(0),
                                    ]),
                                  ),
                                  child: Icon(
                                    Icons.remove,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )
                          ],
                        );
                      }
                    },
                  ),
                ),
                SizedBox(height: 20),
                ForWhoSection(forWho, onForWhoChanged),
                SizedBox(height: 20),
                CategoriesSection(category, onCategoryChanged),
                SizedBox(height: 20),
                EditProductField('Product title', 'Ex. Rounded T-shirt',
                    onTitleChanged, title),
                SizedBox(height: 20),
                EditProductField(
                  'Product description',
                  'Ex. It\'s a rounded t-shirt made out of cotton.',
                  onDescriptionChanged,
                  description,
                  isMultiLine: true,
                ),
                SizedBox(height: 20),
                EditProductField(
                  'Product Price',
                  'Ex. 100',
                  onPriceChanged,
                  price,
                  isNumber: true,
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    RaisedButton(
                      color: Colors.black,
                      child: Text(
                        'Hide Product',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {},
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    RaisedButton(
                      color: Colors.black,
                      child: Text(
                        'Edit Product',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        tryEditProduct();
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        if (loading)
          Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.black38,
            child: Center(child: CircularProgressIndicator()),
          )
      ],
    );
  }
}
