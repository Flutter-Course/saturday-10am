import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:my_shop/widgets/auth_widgets/auth_background.dart';
import 'package:my_shop/widgets/auth_widgets/auth_title.dart';

class AuthScreen extends StatefulWidget {
  static const routeName = '/auth-screen';
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool loginMode, hidePassword, hideConfirmPassword;
  GlobalKey fieldKey;
  double height;
  bool forgotPassowrd;
  @override
  void initState() {
    super.initState();
    forgotPassowrd = false;
    loginMode = true;
    fieldKey = GlobalKey();
    height = 0;
    hidePassword = hideConfirmPassword = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            AuthBackground(),
            AnimatedPositioned(
              duration: Duration(seconds: 1),
              curve: Curves.decelerate,
              right: (forgotPassowrd) ? 0 : -MediaQuery.of(context).size.width,
              child: Container(
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
                        TextFormField(
                          style: TextStyle(
                            color: Colors.white,
                          ),
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
                        Container(
                          width: double.infinity,
                          height: 50,
                          margin: EdgeInsets.only(top: 20),
                          child: Form(
                            child: RaisedButton(
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
                              onPressed: () {},
                            ),
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
                              setState(() {
                                forgotPassowrd = false;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            AnimatedPositioned(
              duration: Duration(seconds: 1),
              curve: Curves.decelerate,
              left: (!forgotPassowrd) ? 0 : -MediaQuery.of(context).size.width,
              child: Container(
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
                        AnimatedSwitcher(
                          duration: Duration(milliseconds: 400),
                          child: (loginMode)
                              ? AuthTitle(UniqueKey(), 'Log into')
                              : AuthTitle(UniqueKey(), 'Create'),
                        ),
                        Form(
                          child: Column(
                            children: [
                              TextFormField(
                                key: fieldKey,
                                style: TextStyle(
                                  color: Colors.white,
                                ),
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
                              TextFormField(
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                                obscureText: hidePassword,
                                decoration: InputDecoration(
                                  hintText: '••••••••',
                                  labelText: 'Password',
                                  suffix: InkWell(
                                    onTap: () {
                                      setState(() {
                                        hidePassword = !hidePassword;
                                      });
                                    },
                                    child: Icon(
                                      (hidePassword)
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Colors.white,
                                    ),
                                  ),
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
                              AnimatedContainer(
                                duration: Duration(seconds: 1),
                                curve: Curves.bounceOut,
                                height: height,
                                child: AnimatedOpacity(
                                  duration: Duration(milliseconds: 400),
                                  opacity: loginMode ? 0 : 1,
                                  child: TextFormField(
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                    obscureText: hideConfirmPassword,
                                    decoration: InputDecoration(
                                      hintText: '••••••••',
                                      labelText: 'Confirm Password',
                                      suffix: InkWell(
                                        onTap: () {
                                          setState(() {
                                            hideConfirmPassword =
                                                !hideConfirmPassword;
                                          });
                                        },
                                        child: Icon(
                                          (hideConfirmPassword)
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: Colors.white,
                                        ),
                                      ),
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
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: FlatButton(
                            padding: EdgeInsets.zero,
                            child: Text(
                              'Forget Password?',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                forgotPassowrd = true;
                              });
                            },
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: 50,
                          child: RaisedButton(
                            shape: StadiumBorder(),
                            color: Theme.of(context).accentColor,
                            child: AnimatedSwitcher(
                              duration: Duration(milliseconds: 400),
                              child: (loginMode)
                                  ? Text(
                                      'Login',
                                      key: UniqueKey(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    )
                                  : Text(
                                      'Register',
                                      key: UniqueKey(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                            ),
                            onPressed: () {},
                          ),
                        ),
                        AnimatedSwitcher(
                          duration: Duration(milliseconds: 400),
                          child: (loginMode)
                              ? Row(
                                  key: UniqueKey(),
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Don\'t have an account?',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    FlatButton(
                                      padding: EdgeInsets.zero,
                                      child: Text(
                                        'Sign Up',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                      onPressed: () {
                                        final ctx = fieldKey.currentContext;
                                        final box =
                                            ctx.findRenderObject() as RenderBox;
                                        setState(() {
                                          loginMode = !loginMode;
                                          height = box.size.height;
                                        });
                                      },
                                    ),
                                  ],
                                )
                              : Row(
                                  key: UniqueKey(),
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Already have an account?',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    FlatButton(
                                      padding: EdgeInsets.zero,
                                      child: Text(
                                        'Sign In',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          loginMode = !loginMode;
                                          height = 0;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
