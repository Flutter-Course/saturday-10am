import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_shop/screens/vendor_screens/products_screen.dart';
import 'package:my_shop/widgets/misc/drawer_item.dart';
import 'package:my_shop/widgets/misc/switch_button.dart';
import 'package:url_launcher/url_launcher.dart';

class VendorDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DrawerItem(
          'Products',
          FontAwesomeIcons.productHunt,
          () {
            Navigator.of(context)
                .pushReplacementNamed(ProductsScreen.routeName);
          },
        ),
        DrawerItem(
          'Orders',
          FontAwesomeIcons.storeAlt,
          () {},
        ),
        DrawerItem(
          'Contact Us',
          Icons.email,
          () {
            launch('mailto:muhammed.aly16@gmail.com?subject=Help');
          },
        ),
        Divider(),
        Text(
          'Social Media',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(FontAwesomeIcons.facebook),
              onPressed: () {
                launch('https://www.facebook.com');
              },
            ),
            IconButton(
              icon: Icon(FontAwesomeIcons.twitter),
              onPressed: () {
                launch('https://www.twitter.com');
              },
            ),
            IconButton(
              icon: Icon(FontAwesomeIcons.instagram),
              onPressed: () {
                launch('https://www.instagram.com');
              },
            ),
          ],
        ),
        Divider(),
        SizedBox(
          height: 10,
        ),
        SwitchButton()
      ],
    );
  }
}
