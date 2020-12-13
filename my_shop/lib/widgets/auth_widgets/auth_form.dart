import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:my_shop/screens/collecting_data_screen.dart';
import 'package:provider/provider.dart';
import 'package:my_shop/providers/user_provider.dart';
import 'package:my_shop/screens/transit_screen.dart';

import 'auth_title.dart';

class AuthForm extends StatefulWidget {
  final Function resetPassword;
  AuthForm(this.resetPassword);
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  bool loginMode;
  double height;
  GlobalKey fieldKey;
  GlobalKey<FormState> form;
  String email, password, confirmPassword;
  bool hidePassword, hideConfirmPassword, loading;
  FocusNode passwordNode, confirmPasswordNode;
  @override
  void initState() {
    super.initState();
    hidePassword = hideConfirmPassword = true;
    fieldKey = GlobalKey();
    form = GlobalKey<FormState>();
    loginMode = true;
    height = 0;
    passwordNode = FocusNode();
    confirmPasswordNode = FocusNode();
    loading = false;
  }

  void showError(String error) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(error),
      backgroundColor: Colors.redAccent,
    ));
  }

  void validateToLogin() async {
    if (form.currentState.validate()) {
      setState(() {
        loading = true;
      });
      String error = await Provider.of<UserProvider>(context, listen: false)
          .login(email, password);
      if (error == null) {
        Navigator.of(context).pushReplacementNamed(TransitScreen.routeName);
      } else {
        setState(() {
          loading = false;
        });
        showError(error);
      }
    }
  }

  void validateToRegister() async {
    if (form.currentState.validate()) {
      setState(() {
        loading = true;
      });

      String error = await Provider.of<UserProvider>(context, listen: false)
          .register(email, password);

      if (error == null) {
        Navigator.of(context).pushReplacementNamed(TransitScreen.routeName);
      } else {
        setState(() {
          loading = false;
        });
        showError(error);
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
              AnimatedSwitcher(
                duration: Duration(milliseconds: 400),
                child: (loginMode)
                    ? AuthTitle(UniqueKey(), 'Log into')
                    : AuthTitle(UniqueKey(), 'Create'),
              ),
              Form(
                key: form,
                child: Column(
                  children: [
                    TextFormField(
                      key: fieldKey,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (value) {
                        passwordNode.requestFocus();
                      },
                      validator: (value) {
                        setState(() {
                          email = value;
                        });

                        if (EmailValidator.validate(email)) {
                          return null;
                        }

                        return 'Invalid email address';
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
                        errorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.redAccent,
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
                        errorStyle: TextStyle(
                          color: Colors.redAccent,
                        ),
                      ),
                    ),
                    TextFormField(
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      obscureText: hidePassword,
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
                        return 'Password must contains 6 characters at least';
                      },
                      focusNode: passwordNode,
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
                        errorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.redAccent,
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
                        errorStyle: TextStyle(
                          color: Colors.redAccent,
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
                          validator: (value) {
                            setState(() {
                              confirmPassword = value;
                            });

                            if (loginMode || value == password) {
                              return null;
                            }

                            return 'Passwords don\'t match';
                          },
                          focusNode: confirmPasswordNode,
                          decoration: InputDecoration(
                            hintText: '••••••••',
                            labelText: 'Confirm Password',
                            suffix: InkWell(
                              onTap: () {
                                setState(() {
                                  hideConfirmPassword = !hideConfirmPassword;
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
                            errorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.redAccent,
                              ),
                            ),
                            labelStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            hintStyle: TextStyle(
                              color: Colors.white,
                            ),
                            errorStyle: TextStyle(
                              color: Colors.redAccent,
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
                    widget.resetPassword();
                  },
                ),
              ),
              Container(
                width: double.infinity,
                height: 50,
                child: (loading)
                    ? Center(child: CircularProgressIndicator())
                    : RaisedButton(
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
                        onPressed: () {
                          if (loginMode) {
                            validateToLogin();
                          } else {
                            validateToRegister();
                          }
                        },
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
                              final box = ctx.findRenderObject() as RenderBox;
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
    );
  }
}
