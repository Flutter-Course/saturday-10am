import 'package:my_shop/models/user.dart';
import 'package:my_shop/models/vendor.dart';

class Customer extends User {
  Customer.fromFirestore(userId, email, document)
      : super.formFireStore(userId, email, document);
  Customer.fromVendor(Vendor vendor)
      : super(
          address: vendor.address,
          email: vendor.email,
          mobileNumber: vendor.mobileNumber,
          photoUrl: vendor.photoUrl,
          position: vendor.position,
          userId: vendor.userId,
          userName: vendor.userName,
        );

  Future<void> init() async {}
}
