import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_shop/models/checkout.dart';
import 'package:my_shop/models/user.dart';
import 'package:my_shop/models/vendor.dart';

import 'cart_item.dart';

class Customer extends User {
  Customer.fromFirestore(id, email, document)
      : super.fromFirestore(id, email, document);

  Customer.fromVendor(Vendor vendor) : super.fromUser(vendor);

  Future<void> init() async {}
  Future<bool> addReview(String text, String productId) async {
    try {
      await FirebaseFirestore.instance
          .collection('products')
          .doc(productId)
          .collection('reviews')
          .add({
        'username': userName,
        'photoUrl': photoUrl,
        'text': text,
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> addOrderWithCash(List<CartItem> items, double amount) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('orders')
          .add({
        'paymentMethod': 'CashOnDelivery',
        'amount': amount,
        'items': items
            .map((cartItem) => {
                  'priductId': cartItem.product.id,
                  'quantity': cartItem.quantity,
                })
            .toList(),
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> addOrderWithCard(List<CartItem> items, double amount,
      String cardNumber, int expiryMonth, int expiryYear, int cvv) async {
    try {
      String token = await Checkout.instance
          .getToken(cardNumber, expiryMonth, expiryYear, cvv);
      print(token);
      bool approved =
          await Checkout.instance.pay(token, (amount * 100).toInt());
      if (approved) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection('orders')
            .add({
          'paymentMethod': 'Card',
          'amount': amount,
          'items': items
              .map((cartItem) => {
                    'priductId': cartItem.product.id,
                    'quantity': cartItem.quantity,
                  })
              .toList(),
        });
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }
}
