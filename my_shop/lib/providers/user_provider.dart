import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_shop/models/customer.dart';
import 'package:my_shop/models/user.dart' as myShop;
import 'package:my_shop/models/vendor.dart';

class UserProvider with ChangeNotifier {
  myShop.User currentUser;

  Future<String> register(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      } else {
        return 'Invalid email address.';
      }
    } catch (e) {
      return 'Network error.';
    }
  }

  Future<String> login(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password' || e.code == 'invalid-email') {
        return 'Invalid email or password.';
      } else if (e.code == 'user-disabled') {
        return 'This account has been disabled.';
      } else {
        return 'No account with this email.';
      }
    } catch (e) {
      return 'Network error.';
    }
  }

  Future<String> resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return null;
    } on FirebaseAuthException catch (e) {
      return 'There is no account with this email';
    } on SocketException catch (e) {
      return 'Network error.';
    } catch (e) {
      return 'Error has been occurred, please try again later.';
    }
  }

  Future<bool> completeProfile(
    String username,
    String mobileNumber,
    String address,
    LatLng position,
    File image,
  ) async {
    try {
      String id = FirebaseAuth.instance.currentUser.uid;
      Reference ref = FirebaseStorage.instance
          .ref('users/$id.${image.path.split('.').last}');
      await ref.putFile(image);
      String imageUrl = await ref.getDownloadURL();
      await FirebaseFirestore.instance.collection('users').doc(id).set({
        'username': username,
        'mobileNumber': mobileNumber,
        'address': address,
        'lat': position.latitude,
        'lng': position.longitude,
        'photoUrl': imageUrl,
        'type': 'Customer',
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> isProfileComplete() async {
    try {
      String id = FirebaseAuth.instance.currentUser.uid;
      String email = FirebaseAuth.instance.currentUser.email;
      final document =
          await FirebaseFirestore.instance.collection('users').doc(id).get();
      if (document.exists) {
        if (document.data()['type'] == 'Customer') {
          currentUser = Customer.fromFirestore(id, email, document);
        } else {
          currentUser = Vendor.fromFirestore(id, email, document);
        }
        await currentUser.init();
        return true;
      } else {
        return false;
      }
    } catch (error) {
      print(error);
      return false;
    }
  }

  bool get isCustomer => currentUser is Customer;

  Future<bool> toggleUserType() async {
    try {
      if (isCustomer) {
        //to vendor
        await FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser.userId)
            .update({'type': 'Vendor'});
        currentUser = Vendor.fromCustomer(currentUser);
      } else {
        //to customer
        await FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser.userId)
            .update({'type': 'Customer'});
        currentUser = Customer.fromVendor(currentUser);
      }
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> addProduct(
      title, description, forWho, category, price, photos) async {
    bool added = await (currentUser as Vendor)
        .addProduct(title, description, forWho, category, price, photos);
    notifyListeners();
    return added;
  }

  Future<bool> editProduct(id, title, description, forWho, category, price,
      photos, available, date) async {
    bool edited = await (currentUser as Vendor).editProduct(id, title,
        description, forWho, category, price, photos, available, date);
    notifyListeners();
    return edited;
  }
}
