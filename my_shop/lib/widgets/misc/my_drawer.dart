import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_shop/models/customer.dart';
import 'package:my_shop/providers/user_provider.dart';
import 'package:my_shop/screens/Auth_screen.dart';
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
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/drawer_background.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              padding: EdgeInsets.all(16),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ImageFrame.fromNetwork(user.photoUrl, 0.5),
                    SizedBox(
                      height: 10,
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        user.userName,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      subtitle: FittedBox(
                        child: Text(
                          user.email,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      trailing: IconButton(
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
