import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class User {
  String photoUrl, address, userName, mobileNumber, email, userId;
  LatLng position;
  User({
    this.address,
    this.email,
    this.mobileNumber,
    this.photoUrl,
    this.position,
    this.userId,
    this.userName,
  });
  User.formFireStore(this.userId, this.email, document)
      : this.photoUrl = document['photoUrl'],
        this.mobileNumber = document['mobileNumber'],
        this.userName = document['userName'],
        this.address = document['address'],
        this.position = LatLng(document['lat'], document['lng']);

  Future<void> init();
}
