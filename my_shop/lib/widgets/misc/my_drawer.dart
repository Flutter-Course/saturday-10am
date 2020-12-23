import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_shop/models/customer.dart';
import 'package:my_shop/models/user.dart';
import 'package:my_shop/providers/user_provider.dart';
import 'package:my_shop/screens/auth_screen.dart';
import 'package:my_shop/widgets/misc/customer_drawer.dart';
import 'package:my_shop/widgets/misc/image_frame.dart';
import 'package:my_shop/widgets/misc/vendor_drawer.dart';
import 'package:provider/provider.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).currentUser;
    bool isCustomer = user is Customer;
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/drawer_background.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ImageFrame.fromNetwork(user.photoUrl, 0.5),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      user.userName,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            user.email,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.exit_to_app,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            FirebaseAuth.instance.signOut();
                            Navigator.of(context)
                                .pushReplacementNamed(AuthScreen.routeName);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            if (isCustomer) CustomerDrawer(),
            if (!isCustomer) VendorDrawer(),
          ],
        ),
      ),
    );
  }
}
