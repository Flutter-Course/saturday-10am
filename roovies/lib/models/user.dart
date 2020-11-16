import 'package:shared_preferences/shared_preferences.dart';

class User {
  final String userId, email;
  DateTime expiryDate;
  String refreshToken, idToken;

  User.fromJson(dynamic json)
      : this.userId = json['localId'],
        this.email = json['email'],
        this.idToken = json['idToken'],
        this.refreshToken = json['refreshToken'],
        this.expiryDate =
            DateTime.now().add(Duration(seconds: int.parse(json['expiresIn'])));

  User.fromPrefs(SharedPreferences prefs)
      : this.userId = prefs.get('userId'),
        this.email = prefs.get('email'),
        this.idToken = prefs.get('idToken'),
        this.refreshToken = prefs.get('refreshToken'),
        this.expiryDate = DateTime.parse(prefs.get('expiryDate'));
}
