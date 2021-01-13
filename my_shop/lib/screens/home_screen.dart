import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_shop/providers/cart.dart';
import 'package:my_shop/providers/products_provider.dart';
import 'package:my_shop/screens/auth_screen.dart';
import 'package:my_shop/screens/filter_screen.dart';
import 'package:my_shop/widgets/misc/my_drawer.dart';
import 'package:my_shop/widgets/misc/product_item.dart';
import 'package:my_shop/widgets/misc/shopping_cart.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool firstRun, successful;

  @override
  void initState() {
    super.initState();
    firstRun = true;
    successful = false;
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (firstRun) {
      fetchProducts();
    }
  }

  void fetchProducts() async {
    bool fetched = await Provider.of<ProductsProvider>(context, listen: false)
        .fetchProducts();
    setState(() {
      firstRun = false;
      successful = fetched;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text('MyShop'),
        actions: [
          if (Provider.of<Cart>(context).items.length > 0) ShoppingCart()
        ],
      ),
      body: (firstRun)
          ? Center(child: CircularProgressIndicator())
          : (successful)
              ? StaggeredGridView.countBuilder(
                  padding: EdgeInsets.all(16),
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  itemCount: Provider.of<ProductsProvider>(context)
                          .selectedProducts
                          .length +
                      1,
                  crossAxisSpacing: 10,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return InkWell(
                        onTap: () async {
                          bool filter = await Navigator.of(context).push(
                              MaterialPageRoute<bool>(
                                  builder: (context) => FilterScreen()));
                          if (filter) {
                            setState(() {
                              firstRun = true;
                            });
                            fetchProducts();
                          }
                        },
                        child: Hero(
                          tag: 'filter',
                          child: Card(
                            color: Colors.white,
                            elevation: 8,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            margin: EdgeInsets.zero,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  FontAwesomeIcons.filter,
                                  color: Colors.black,
                                  size: 40,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Material(
                                  color: Colors.transparent,
                                  child: Text(
                                    'Filter Products',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    } else {
                      return ProductItem(
                          Provider.of<ProductsProvider>(context)
                              .selectedProducts[index - 1],
                          false);
                    }
                  },
                  staggeredTileBuilder: (index) {
                    return StaggeredTile.count(1, index == 0 ? 1 : 2);
                  },
                )
              : Center(
                  child: Text('error has occurred'),
                ),
    );
  }
}
