import 'package:dio/dio.dart';
import 'package:roovies/helpers/api_keys.dart';
import 'package:roovies/models/movie.dart';
import 'package:roovies/models/user.dart';

class FireBaseHandler {
  static FireBaseHandler _instance = FireBaseHandler._private();
  FireBaseHandler._private();

  static FireBaseHandler get instance => _instance;

  String mainUrl = 'https://roovies-sat-1.firebaseio.com';
  Dio _dio = Dio();

  Future<void> addFavorite(Movie movie, User user) async {
    String url = '$mainUrl/users/${user.userId}/favorites/${movie.id}.json';
    final params = {'auth': user.idToken};
    await _dio.put(url, queryParameters: params, data: {
      'id': movie.id,
      'vote_average': movie.rating,
      'title': movie.title,
      'poster_path': movie.posterUrl.split('/').last,
      'backdrop_path': movie.backPosterUrl.split('/').last
    });
  }

  Future<void> deleteFavorite(Movie movie, User user) async {
    String url = '$mainUrl/users/${user.userId}/favorites/${movie.id}.json';
    final params = {
      'auth': user.idToken,
    };
    await _dio.delete(url, queryParameters: params);
  }

  Future<User> signUp(String email, String password) async {
    String url = 'https://identitytoolkit.googleapis.com/v1/accounts:signUp';
    final params = {
      'key': ApiKeys.firebaseKey,
    };

    Response response = await _dio.post(
      url,
      queryParameters: params,
      data: {
        'email': email,
        'password': password,
        'returnSecureToken': true,
      },
    );
    return User.fromJson(response.data);
  }

  Future<User> signIn(String email, String password) async {
    String url =
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword';
    final params = {
      'key': ApiKeys.firebaseKey,
    };

    Response response = await _dio.post(
      url,
      queryParameters: params,
      data: {
        'email': email,
        'password': password,
        'returnSecureToken': true,
      },
    );
    return User.fromJson(response.data);
  }

  Future<User> refreshToken(User user) async {
    String url = 'https://securetoken.googleapis.com/v1/token';
    final params = {
      'key': ApiKeys.firebaseKey,
    };
    Response response = await _dio.post(
      url,
      queryParameters: params,
      data: {
        'grant_type': 'refresh_token',
        'refresh_token': user.refreshToken,
      },
    );

    user.idToken = response.data['id_token'];
    user.refreshToken = response.data['refresh_token'];
    user.expiryDate = DateTime.now().add(
      Duration(
        seconds: int.parse(
          response.data['expires_in'],
        ),
      ),
    );
    return user;
  }

  Future<List<Movie>> favorites(User user) async {
    String url = '$mainUrl/users/${user.userId}/favorites.json';
    final params = {
      'auth': user.idToken,
    };
    Response response = await _dio.get(
      url,
      queryParameters: params,
    );
    if (response.data != null) {
      List<Movie> favs = (response.data as Map).entries.map((e) {
        return Movie.fromJson(e.value);
      }).toList();
      return favs;
    } else {
      return [];
    }
  }
}
