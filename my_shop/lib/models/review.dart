import 'package:cloud_firestore/cloud_firestore.dart';

class Review {
  String _id, _userName, _userPhoto, _text;

  String get id => _id;

  String get userName => _userName;

  String get userPhoto => _userPhoto;

  String get text => _text;

  Review.fromFirestore(QueryDocumentSnapshot document)
      : _id = document.id,
        _userName = document.data()['username'],
        _userPhoto = document.data()['photoUrl'],
        _text = document.data()['text'];
}
