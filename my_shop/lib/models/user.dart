import 'package:google_maps_flutter/google_maps_flutter.dart';

class User {
  String photoUrl, address, userName, mobileNumber, email, userId;
  LatLng position;

  User.formFireStore(this.userId, this.email, document)
      : this.photoUrl = document['photoUrl'],
        this.mobileNumber = document['mobileNumber'],
        this.userName = document['userName'],
        this.address = document['address'],
        this.position = LatLng(document['lat'], document['lng']);
}
