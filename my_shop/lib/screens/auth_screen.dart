import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:my_shop/widgets/auth_widgets/auth_background.dart';
import 'package:my_shop/widgets/auth_widgets/auth_form.dart';
import 'package:my_shop/widgets/auth_widgets/auth_title.dart';
import 'package:my_shop/widgets/auth_widgets/reset_password_form.dart';

class AuthScreen extends StatefulWidget {
  static const routeName = '/auth-screen';
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool forgotPassowrd;
  @override
  void initState() {
    super.initState();
    forgotPassowrd = false;
  }

  void toggleReset() {
    setState(() {
      forgotPassowrd = !forgotPassowrd;
    });
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
              child: ResetPasswordForm(toggleReset),
            ),
            AnimatedPositioned(
              duration: Duration(seconds: 1),
              curve: Curves.decelerate,
              left: (!forgotPassowrd) ? 0 : -MediaQuery.of(context).size.width,
              child: AuthForm(toggleReset),
            )
          ],
        ),
      ),
    );
  }
}
