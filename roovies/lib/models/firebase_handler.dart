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

  Future<void> addFavorite(Movie movie) async {
    String url = '$mainUrl/users/userId/favorites/${movie.id}.json';
    await _dio.put(url, data: {
      'id': movie.id,
      'vote_average': movie.rating,
      'title': movie.title,
      'poster_path': movie.posterUrl.split('/').last,
      'backdrop_path': movie.backPosterUrl.split('/').last
    });
  }

  Future<void> deleteFavorite(Movie movie) async {
    String url = '$mainUrl/users/userId/favorites/${movie.id}.json';
    await _dio.delete(url);
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
}
