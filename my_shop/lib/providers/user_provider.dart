import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_shop/models/customer.dart';
import 'package:my_shop/models/user.dart' as myApp;
import 'package:my_shop/models/vendor.dart';

class UserProvider with ChangeNotifier {
  myApp.User currentUser;
  Future<String> login(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return null;
    } catch (e) {
      switch (e.code) {
        case 'invalid-email':
          return 'Invalid email or pasword.';
        case 'wrong-password':
          return 'Invalid email or pasword.';
        case 'user-disabled':
          return 'This user has been disabled.';
        default:
          return 'User not found.';
      }
    }
  }

  Future<String> register(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return null;
    } catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          return 'This email is already in use.';
        case 'invalid-email':
          return 'You have entered an invalid email.';
        default:
          return 'You have entered a weak password.';
      }
    }
  }

  Future<String> resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return null;
    } catch (e) {
      return 'Error has occurred';
    }
  }

  Future<bool> updateProfile(File image, String userName, String mobileNumber,
      LatLng position, String address) async {
    try {
      String userId = FirebaseAuth.instance.currentUser.uid;
      String email = FirebaseAuth.instance.currentUser.email;
      final ref = FirebaseStorage.instance
          .ref('users/$userId.${image.path.split('.').last}');
      await ref.putFile(image);

      String photoUrl = await ref.getDownloadURL();
      await FirebaseFirestore.instance.collection('users').doc(userId).set(
        {
          'type': 'customer',
          'email': email,
          'userName': userName,
          'photoUrl': photoUrl,
          'mobileNumber': mobileNumber,
          'lat': position.latitude,
          'lng': position.longitude,
          'address': address,
        },
      );
      return true;
    } catch (error) {
      return false;
    }
  }

  Future<bool> profileComplete() async {
    try {
      String userId = FirebaseAuth.instance.currentUser.uid;
      String email = FirebaseAuth.instance.currentUser.email;
      final document = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();
      if (document.exists) {
        //load data
        if (document['type'] == 'customer') {
          currentUser = Customer.fromFirestore(userId, email, document);
        } else {
          currentUser = Vendor.formFireStore(userId, email, document);
        }
        await currentUser.init();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> switchUserType() async {
    try {
      if (isCustomer) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser.userId)
            .update({
          'type': 'vendor',
        });
        currentUser = Vendor.fromCustomer(currentUser);
      } else {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser.userId)
            .update({
          'type': 'customer',
        });
        currentUser = Customer.fromVendor(currentUser);
      }

      currentUser.init();

      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  bool get isCustomer => currentUser is Customer;
}
