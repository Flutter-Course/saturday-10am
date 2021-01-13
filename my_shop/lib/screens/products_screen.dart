import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:my_shop/models/vendor.dart';
import 'package:my_shop/providers/user_provider.dart';
import 'package:my_shop/screens/add_product_screen.dart';
import 'package:my_shop/widgets/misc/my_drawer.dart';
import 'package:my_shop/widgets/misc/product_item.dart';
import 'package:provider/provider.dart';

class ProductsScreen extends StatelessWidget {
  static const routeName = '/products-screen';
  @override
  Widget build(BuildContext context) {
    final products =
        (Provider.of<UserProvider>(context).currentUser as Vendor).products;
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text('My Products'),
      ),
      body: StaggeredGridView.countBuilder(
        padding: EdgeInsets.all(16),
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        itemCount: products.length + 1,
        crossAxisSpacing: 10,
        itemBuilder: (context, index) {
          if (index == 0) {
            return InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(AddProductScreen.routeName);
              },
              child: Card(
                color: Colors.grey,
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                margin: EdgeInsets.zero,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 40,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Add Product',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return ProductItem(products[index - 1]);
          }
        },
        staggeredTileBuilder: (index) {
          return StaggeredTile.count(1, index == 0 ? 1 : 2);
        },
      ),
    );
  }
}
