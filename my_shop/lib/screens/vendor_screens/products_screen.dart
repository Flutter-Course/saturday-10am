import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:my_shop/models/vendor.dart';
import 'package:my_shop/providers/user_provider.dart';
import 'package:my_shop/screens/vendor_screens/add_product_screen.dart';
import 'package:my_shop/widgets/misc/my_drawer.dart';
import 'package:provider/provider.dart';

class ProductsScreen extends StatelessWidget {
  static const routeName = '/products';
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
        padding: EdgeInsets.all(8),
        mainAxisSpacing: 5,
        crossAxisSpacing: 5,
        crossAxisCount: 2,
        itemCount: products.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(AddProductScreen.routeName);
              },
              child: Card(
                  elevation: 8,
                  margin: EdgeInsets.zero,
                  color: Colors.grey[300],
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add,
                        size: 40,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text('Add Product'),
                    ],
                  )),
            );
          } else {
            return Container(
              color: Colors.green,
            );
          }
        },
        staggeredTileBuilder: (index) {
          return StaggeredTile.count(1, index == 0 ? 1 : 2);
        },
      ),
    );
  }
}
