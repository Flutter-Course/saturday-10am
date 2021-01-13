import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_shop/models/PaymentCard.dart';
import 'package:my_shop/models/customer.dart';
import 'package:my_shop/providers/cart.dart';
import 'package:my_shop/providers/user_provider.dart';
import 'package:my_shop/screens/home_screen.dart';
import 'package:provider/provider.dart';

class CheckoutScreen extends StatefulWidget {
  static const routeName = '/checkout';

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String paymentMethod, number, month, year, cvv;
  bool loading;
  @override
  void initState() {
    super.initState();
    loading = false;
    paymentMethod = 'Cash';
  }

  void addOrder() async {
    if (paymentMethod == 'Cash') {
      setState(() {
        loading = true;
      });
      bool added = await (Provider.of<UserProvider>(context, listen: false)
              .currentUser as Customer)
          .addOrderWithCash(Provider.of<Cart>(context, listen: false).items,
              Provider.of<Cart>(context, listen: false).amount);
      if (added) {
        Provider.of<Cart>(context, listen: false).clearCart();
        Navigator.of(context).popUntil((route) => route.isFirst);
      } else {
        //show error
        setState(() {
          loading = false;
        });
      }
    } else {
      setState(() {
        loading = true;
      });
      bool added = await (Provider.of<UserProvider>(context, listen: false)
              .currentUser as Customer)
          .addOrderWithCard(
              Provider.of<Cart>(context, listen: false).items,
              Provider.of<Cart>(context, listen: false).amount,
              number,
              int.parse(month),
              int.parse(year),
              int.parse(cvv));
      if (added) {
        Provider.of<Cart>(context, listen: false).clearCart();
        Navigator.of(context).popUntil((route) => route.isFirst);
      } else {
        //show error
        setState(() {
          loading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Delivery Details',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Card(
                    margin: EdgeInsets.zero,
                    elevation: 10,
                    child: Container(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(FontAwesomeIcons.user),
                              SizedBox(
                                width: 10,
                              ),
                              Text(Provider.of<UserProvider>(context)
                                  .currentUser
                                  .userName),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Icon(FontAwesomeIcons.mapPin),
                              SizedBox(
                                width: 10,
                              ),
                              Flexible(
                                child: Text(
                                  Provider.of<UserProvider>(context)
                                      .currentUser
                                      .address,
                                  softWrap: true,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Icon(FontAwesomeIcons.mobile),
                              SizedBox(
                                width: 10,
                              ),
                              Text(Provider.of<UserProvider>(context)
                                  .currentUser
                                  .mobileNumber),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  Text(
                    'Payment Method',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Card(
                    margin: EdgeInsets.zero,
                    elevation: 10,
                    child: Container(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        children: [
                          ListTile(
                            onTap: () {
                              setState(() {
                                paymentMethod = 'Cash';
                              });
                            },
                            contentPadding: EdgeInsets.only(right: 16),
                            leading: Radio(
                              value: 'Cash',
                              groupValue: paymentMethod,
                              onChanged: (value) {
                                setState(() {
                                  paymentMethod = value;
                                });
                              },
                            ),
                            title: Text('Cash on delivery'),
                            trailing: Icon(
                              FontAwesomeIcons.moneyBillWave,
                              color: Colors.black,
                            ),
                          ),
                          Divider(
                            color: Colors.grey[600],
                          ),
                          ListTile(
                            onTap: () {
                              setState(() {
                                paymentMethod = 'Card';
                              });
                            },
                            contentPadding: EdgeInsets.only(right: 16),
                            leading: Radio(
                              value: 'Card',
                              groupValue: paymentMethod,
                              onChanged: (value) {
                                setState(() {
                                  paymentMethod = 'Card';
                                });
                              },
                            ),
                            title: Text('Credit Card'),
                            trailing: Icon(
                              FontAwesomeIcons.creditCard,
                              color: Colors.black,
                            ),
                          ),
                          Form(
                            child: Column(
                              children: [
                                TextFormField(
                                  enabled: paymentMethod == 'Card',
                                  onChanged: (value) {
                                    setState(() {
                                      number = value;
                                    });
                                  },
                                  decoration: InputDecoration(
                                    labelText: 'Card Number',
                                  ),
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: TextFormField(
                                              onChanged: (value) {
                                                setState(() {
                                                  month = value;
                                                });
                                              },
                                              textAlign: TextAlign.center,
                                              enabled: paymentMethod == 'Card',
                                              decoration: InputDecoration(
                                                labelText: 'MM',
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 16),
                                            child: Text('/'),
                                          ),
                                          Expanded(
                                            child: TextFormField(
                                              onChanged: (value) {
                                                setState(() {
                                                  year = value;
                                                });
                                              },
                                              textAlign: TextAlign.center,
                                              enabled: paymentMethod == 'Card',
                                              decoration: InputDecoration(
                                                labelText: 'YY',
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      flex: 2,
                                    ),
                                    Expanded(
                                      child: Container(),
                                    ),
                                    Expanded(
                                      child: TextField(
                                        onChanged: (value) {
                                          setState(() {
                                            cvv = value;
                                          });
                                        },
                                        enabled: paymentMethod == 'Card',
                                        decoration: InputDecoration(
                                          labelText: 'CVV',
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: addOrder,
            child: Container(
              padding: EdgeInsets.all(16),
              color: Colors.black,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Place Order',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
