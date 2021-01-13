import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_shop/models/customer.dart';
import 'package:my_shop/providers/user_provider.dart';
import 'package:provider/provider.dart';

class AddReviewSheet extends StatefulWidget {
  final String productID;

  AddReviewSheet(this.productID);

  @override
  _AddReviewSheetState createState() => _AddReviewSheetState();
}

class _AddReviewSheetState extends State<AddReviewSheet> {
  TextEditingController review;
  GlobalKey<FormState> form;
  bool loading;

  @override
  void initState() {
    super.initState();
    form = GlobalKey<FormState>();
    review = TextEditingController();
    loading = false;
  }

  void tryAddReview() async {
    if (form.currentState.validate()) {
      setState(() {
        loading = true;
      });
      bool added = await (Provider.of<UserProvider>(context, listen: false)
              .currentUser as Customer)
          .addReview(review.text, widget.productID);
      if (added) {
        Navigator.of(context).pop();
      } else {
        setState(() {
          loading = false;
        });
        showDialog(
          context: context,
          child: AlertDialog(
            title: Text('Error occurred'),
            content: Text(
                'Review couldn\'t be added at the momment, please try again later.'),
            actions: [
              FlatButton(
                child: Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8).add(
            EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom, top: 8),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!loading) ...[
                Text(
                  'Add Review',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Form(
                  key: form,
                  child: TextFormField(
                    controller: review,
                    keyboardType: TextInputType.multiline,
                    maxLines: 5,
                    validator: (value) {
                      if (value.trim().length < 3) {
                        return 'Please enter at least 3 characters.';
                      }
                      return null;
                    },
                    scrollPhysics: BouncingScrollPhysics(),
                    decoration: InputDecoration(
                      hintText: 'Please leave a respectful and true review.',
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.black, width: 2),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide:
                            BorderSide(color: Colors.red[900], width: 2),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide:
                            BorderSide(color: Colors.red[900], width: 2),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: RaisedButton(
                    color: Colors.black,
                    child: Text(
                      'Add',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: tryAddReview,
                  ),
                )
              ],
              if (loading)
                Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
