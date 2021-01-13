import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:my_shop/providers/user_provider.dart';
import 'package:my_shop/widgets/auth_widgets/auth_title.dart';
import 'package:provider/provider.dart';

class ResetPasswordForm extends StatefulWidget {
  final Function toggleResetPassword;
  ResetPasswordForm(this.toggleResetPassword);
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
    loading = false;
    form = GlobalKey<FormState>();
  }

  void tryToResetPassword() async {
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
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text(error),
          backgroundColor: Colors.red[900],
        ));
      }

      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(30, 30, 30, 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AuthTitle(UniqueKey(), 'Reset password of'),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Form(
                key: form,
                child: Column(
                  children: [
                    TextFormField(
                      validator: (value) {
                        setState(() {
                          email = value;
                        });
                        if (EmailValidator.validate(value)) {
                          return null;
                        }
                        return 'Email validator';
                      },
                      style: TextStyle(color: Colors.white),
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        errorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.redAccent,
                          ),
                        ),
                        errorStyle: TextStyle(color: Colors.redAccent),
                        hintText: 'example@abc.com',
                        labelText: 'Email',
                        labelStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        hintStyle: TextStyle(
                          color: Colors.white,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white, width: 1),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              (loading)
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Container(
                      width: double.infinity,
                      height: 50,
                      child: RaisedButton(
                        shape: StadiumBorder(),
                        color: Colors.black,
                        child: Text(
                          'Reset Password',
                          key: UniqueKey(),
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                          tryToResetPassword();
                        },
                      ),
                    ),
              Align(
                alignment: Alignment.center,
                child: FlatButton(
                  padding: EdgeInsets.zero,
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    widget.toggleResetPassword();
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
