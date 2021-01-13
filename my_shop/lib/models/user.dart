import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class User {
  String userId, email, userName, mobileNumber, address, photoUrl;
  LatLng position;

  User.fromFirestore(id, email, document)
      : this.userName = document['username'],
        this.mobileNumber = document['mobileNumber'],
        this.address = document['address'],
        this.photoUrl = document['photoUrl'],
        this.position = LatLng(document['lat'], document['lng']),
        this.userId = id,
        this.email = email;

  User.fromUser(User user)
      : this.userName = user.userName,
        this.mobileNumber = user.mobileNumber,
        this.address = user.address,
        this.photoUrl = user.photoUrl,
        this.position = user.position,
        this.userId = user.userId,
        this.email = user.email;

  Future<void> init();
}
