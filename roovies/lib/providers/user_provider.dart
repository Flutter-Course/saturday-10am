import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:roovies/models/firebase_handler.dart';
import 'package:roovies/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider with ChangeNotifier {
  User currentUser;

  Future<void> saverUserData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('idToken', currentUser.idToken);
    preferences.setString('refreshToken', currentUser.refreshToken);
    preferences.setString('email', currentUser.email);
    preferences.setString('expiryDate', currentUser.expiryDate.toString());
    preferences.setString('userId', currentUser.userId);
  }

  Future<void> cleareUserData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove('idToken');
    preferences.remove('refreshToken');
    preferences.remove('email');
    preferences.remove('expiryDate');
    preferences.remove('userId');
  }

  Future<String> signUp(String email, String password) async {
    try {
      currentUser = await FireBaseHandler.instance.signUp(email, password);
      await saverUserData();
      return null;
    } on DioError catch (error) {
      if (error.response.data['error']['message'] == 'EMAIL_EXISTS') {
        return 'Email already exists.';
      } else if (error.response.data['error']['message'] ==
          'TOO_MANY_ATTEMPTS_TRY_LATER')
        return 'Too many attempts please try again later.';
    }
  }

  Future<String> signIn(String email, String password) async {
    try {
      currentUser = await FireBaseHandler.instance.signIn(email, password);
      await saverUserData();
      return null;
    } on DioError catch (error) {
      if (error.response.data['error']['message'] == 'EMAIL_NOT_FOUND' ||
          error.response.data['error']['message'] == 'INVALID_PASSWORD') {
        return 'Wrong email or password.';
      } else if (error.response.data['error']['message'] == 'USER_DISABLED')
        return 'This user has been disapled.';
    }
  }

  Future<bool> isLoggedIn() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.containsKey('idToken')) {
      currentUser = User.fromPrefs(preferences);
      print('here');
      return true;
    } else {
      return false;
    }
  }
}
