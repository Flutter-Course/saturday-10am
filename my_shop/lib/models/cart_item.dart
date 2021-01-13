import 'package:my_shop/models/product.dart';

class CartItem {
  Product product;
  int quantity;

  CartItem(this.product, this.quantity);
}
