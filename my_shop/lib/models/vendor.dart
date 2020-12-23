import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:my_shop/models/customer.dart';
import 'package:my_shop/models/product.dart';
import 'package:my_shop/models/user.dart';

class Vendor extends User {
  List<Product> products;
  Vendor.formFireStore(userId, email, document)
      : super.formFireStore(userId, email, document);

  Vendor.fromCustomer(Customer customer)
      : super(
          address: customer.address,
          email: customer.email,
          mobileNumber: customer.mobileNumber,
          photoUrl: customer.photoUrl,
          position: customer.position,
          userId: customer.userId,
          userName: customer.userName,
        );

  Future<void> init() async {
    final query = await FirebaseFirestore.instance
        .collection('products')
        .where(
          'vendorId',
          isEqualTo: this.userId,
        )
        .get();
    if (query.size == 0) {
      products = [];
    } else {
      products = query.docs
          .map(
            (document) => Product.fromDocument(document),
          )
          .toList();
    }
  }
}
