import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:my_shop/providers/user_provider.dart';
import 'package:my_shop/screens/transit_screen.dart';
import 'package:my_shop/widgets/auth_widgets/auth_title.dart';
import 'package:provider/provider.dart';

class AuthForm extends StatefulWidget {
  final Function toggleResetPassword;
  AuthForm(this.toggleResetPassword);
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  String email, password;
  bool hidePassword, hideConfirmPassword, loginMode;
  FocusNode passwordNode, confirmPasswordNode;
  double height;
  GlobalKey field;
  GlobalKey<FormState> form;
  bool loading;

  @override
  void initState() {
    super.initState();
    loading = false;
    passwordNode = FocusNode();
    confirmPasswordNode = FocusNode();
    hideConfirmPassword = hidePassword = loginMode = true;
    height = 0;
    field = GlobalKey();
    form = GlobalKey<FormState>();
  }

  void tryToLogin() async {
    if (form.currentState.validate()) {
      setState(() {
        loading = true;
      });
      String error = await Provider.of<UserProvider>(context, listen: false)
          .login(email, password);
      if (error == null) {
        //home screen
        Navigator.of(context).pushReplacementNamed(TransitScreen.routeName);
      } else {
        setState(() {
          loading = false;
        });
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text(error),
          backgroundColor: Colors.red[900],
        ));
      }
    }
  }

  void tryToRegister() async {
    if (form.currentState.validate()) {
      setState(() {
        loading = true;
      });
      String error = await Provider.of<UserProvider>(context, listen: false)
          .register(email, password);
      if (error == null) {
        //home screen
        Navigator.of(context).pushReplacementNamed(TransitScreen.routeName);
      } else {
        setState(() {
          loading = false;
        });
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text(error),
          backgroundColor: Colors.red[900],
        ));
      }
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
              AnimatedSwitcher(
                duration: Duration(milliseconds: 400),
                child: (loginMode)
                    ? AuthTitle(UniqueKey(), 'Login into')
                    : AuthTitle(UniqueKey(), 'Create'),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Form(
                key: form,
                child: Column(
                  children: [
                    TextFormField(
                      key: field,
                      style: TextStyle(color: Colors.white),
                      keyboardType: TextInputType.emailAddress,
                      onFieldSubmitted: (value) {
                        passwordNode.requestFocus();
                      },
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        setState(() {
                          email = value;
                        });
                        if (EmailValidator.validate(value)) {
                          return null;
                        }
                        return 'Invalid email';
                      },
                      decoration: InputDecoration(
                        errorStyle: TextStyle(color: Colors.redAccent),
                        errorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.redAccent,
                          ),
                        ),
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
                    TextFormField(
                      style: TextStyle(color: Colors.white),
                      obscureText: hidePassword,
                      focusNode: passwordNode,
                      textInputAction: (loginMode)
                          ? TextInputAction.done
                          : TextInputAction.next,
                      onFieldSubmitted: (value) {
                        if (!loginMode) {
                          confirmPasswordNode.requestFocus();
                        }
                      },
                      validator: (value) {
                        setState(() {
                          password = value;
                        });
                        if (value.length >= 6) {
                          return null;
                        }
                        return 'Password must contain 6 characters at least';
                      },
                      decoration: InputDecoration(
                        errorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.redAccent,
                          ),
                        ),
                        errorStyle: TextStyle(color: Colors.redAccent),
                        hintText: '••••••••',
                        labelText: 'Password',
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
                        suffix: GestureDetector(
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
                      ),
                    ),
                    AnimatedContainer(
                      duration: Duration(seconds: 1),
                      height: height,
                      curve: Curves.bounceOut,
                      child: AnimatedOpacity(
                        duration: Duration(milliseconds: 400),
                        opacity: loginMode ? 0 : 1,
                        child: TextFormField(
                          style: TextStyle(color: Colors.white),
                          obscureText: hideConfirmPassword,
                          focusNode: confirmPasswordNode,
                          validator: (confirmPassword) {
                            if (loginMode || password == confirmPassword) {
                              return null;
                            }
                            return 'Passwords must match';
                          },
                          decoration: InputDecoration(
                            errorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.redAccent,
                              ),
                            ),
                            errorStyle: TextStyle(color: Colors.redAccent),
                            hintText: '••••••••',
                            labelText: 'Confirm Password',
                            labelStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            hintStyle: TextStyle(
                              color: Colors.white,
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 1),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                                width: 2,
                              ),
                            ),
                            suffix: GestureDetector(
                              onLongPressStart: (_) {
                                setState(() {
                                  hideConfirmPassword = !hideConfirmPassword;
                                });
                              },
                              onLongPressEnd: (details) {
                                setState(() {
                                  hideConfirmPassword = !hideConfirmPassword;
                                });
                              },
                              child: Icon(
                                Icons.visibility,
                                color: Colors.white,
                              ),
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
                    'Reset Password',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    widget.toggleResetPassword();
                  },
                ),
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
                        child: AnimatedSwitcher(
                          duration: Duration(milliseconds: 400),
                          child: (loginMode)
                              ? Text(
                                  'Login',
                                  key: UniqueKey(),
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                )
                              : Text(
                                  'Register',
                                  key: UniqueKey(),
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                        onPressed: () {
                          if (loginMode) {
                            tryToLogin();
                          } else {
                            tryToRegister();
                          }
                        },
                      ),
                    ),
              AnimatedSwitcher(
                duration: Duration(milliseconds: 400),
                child: (loginMode)
                    ? FlatButton(
                        key: UniqueKey(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t have an account?',
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Register!',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline),
                            ),
                          ],
                        ),
                        onPressed: () {
                          final ctx = field.currentContext;
                          final box = ctx.findRenderObject() as RenderBox;
                          setState(() {
                            height = box.size.height + 20;
                            loginMode = !loginMode;
                          });
                        },
                      )
                    : FlatButton(
                        key: UniqueKey(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already have an account?',
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Login!',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline),
                            ),
                          ],
                        ),
                        onPressed: () {
                          setState(() {
                            height = 0;
                            loginMode = !loginMode;
                          });
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
