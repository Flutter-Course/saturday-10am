import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:my_shop/providers/user_provider.dart';

import 'auth_title.dart';

class ResetPasswordForm extends StatefulWidget {
  final Function resetPassword;
  ResetPasswordForm(this.resetPassword);
  @override
  _ResetPasswordFormState createState() => _ResetPasswordFormState();
}

class _ResetPasswordFormState extends State<ResetPasswordForm> {
  GlobalKey<FormState> form;
  String email;
  bool loading;

  @override
  void initState() {
    super.initState();
    form = GlobalKey<FormState>();
    loading = false;
  }

  void showError(String error) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(error),
      backgroundColor: Colors.redAccent,
    ));
  }

  void validateToResetPassword() async {
    if (form.currentState.validate()) {
      setState(() {
        loading = true;
      });

      String error = await Provider.of<UserProvider>(context, listen: false)
          .resetPassword(email);
      if (error == null) {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text('Email has been sent.'),
          backgroundColor: Colors.green[900],
        ));
      } else {
        showError('Error has occurred');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 30).add(
            EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.05,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AuthTitle(UniqueKey(), 'Reset password of'),
              Form(
                key: form,
                child: TextFormField(
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  validator: (value) {
                    setState(() {
                      email = value;
                    });

                    if (EmailValidator.validate(email)) {
                      return null;
                    }

                    return 'Please enter your email';
                  },
                  decoration: InputDecoration(
                    hintText: 'example@abc.com',
                    labelText: 'Email',
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 3,
                      ),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    hintStyle: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: 50,
                margin: EdgeInsets.only(top: 20),
                child: (loading)
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : RaisedButton(
                        shape: StadiumBorder(),
                        color: Theme.of(context).accentColor,
                        child: Text(
                          'Reset Password',
                          key: UniqueKey(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        onPressed: () {
                          validateToResetPassword();
                        },
                      ),
              ),
              Align(
                alignment: Alignment.center,
                child: FlatButton(
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    widget.resetPassword();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
