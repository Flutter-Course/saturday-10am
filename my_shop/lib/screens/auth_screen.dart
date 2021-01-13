import 'package:flutter/material.dart';
import 'package:my_shop/widgets/auth_widgets/auth_background.dart';
import 'package:my_shop/widgets/auth_widgets/auth_form.dart';
import 'package:my_shop/widgets/auth_widgets/reset_password_form.dart';

class AuthScreen extends StatefulWidget {
  static const routeName = '/Auth-Screen';
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool resetPassword;
  @override
  void initState() {
    super.initState();
    resetPassword = false;
  }

  void toggleResetPassword() {
    setState(() {
      resetPassword = !resetPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AuthBackground(),
          AnimatedPositioned(
            curve: Curves.decelerate,
            duration: Duration(seconds: 1),
            left: (resetPassword) ? -MediaQuery.of(context).size.width : 0,
            child: AuthForm(toggleResetPassword),
          ),
          AnimatedPositioned(
            curve: Curves.decelerate,
            duration: Duration(seconds: 1),
            left: (resetPassword) ? 0 : MediaQuery.of(context).size.width,
            child: ResetPasswordForm(toggleResetPassword),
          ),
        ],
      ),
    );
  }
}
