import 'dart:collection';
import 'dart:math';

import 'package:delivery_manager/models/order.dart';
import 'package:delivery_manager/widgets/add_order_sheet.dart';
import 'package:delivery_manager/widgets/background_container.dart';
import 'package:delivery_manager/widgets/chart.dart';
import 'package:delivery_manager/widgets/homescreen_header.dart';
import 'package:delivery_manager/widgets/order_item.dart';
import 'package:delivery_manager/widgets/sticky_header_head.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sticky_headers/sticky_headers.dart';

class HomeScreen extends StatefulWidget {
  final Function toggleTheme;
  HomeScreen(this.toggleTheme);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController scrollController = ScrollController();
  bool showUpButton = false;
  SplayTreeMap<String, Map<String, dynamic>> orders =
      SplayTreeMap<String, Map<String, dynamic>>((String a, String b) {
    return -a.compareTo(b);
  });
  List<String> deliveryMen = ['Muhammed Aly', 'Toka Ehab', 'Ahmed Aly'];
  DateTime selectedDate;
  SplayTreeSet<Order> selectedOrders;
  bool dark;
  void changeSelectedDate(DateTime date) {
    setState(() {
      selectedDate = date;
      String key = DateFormat('yyyyMMdd').format(selectedDate);
      if (orders.containsKey(key)) {
        selectedOrders = orders[key]['list'];
      } else {
        selectedOrders = null;
      }
    });
  }

  void addOrder(String key, Order order) {
    Navigator.of(context).pop();
    setState(() {
      if (orders.containsKey(key)) {
        orders[key]['list'].add(order);
      } else {
        orders[key] = Map<String, dynamic>();
        orders[key]['date'] =
            DateFormat('EEEE, dd/MM/yyyy').format(order.orderDate);
        orders[key]['list'] = SplayTreeSet<Order>((Order a, Order b) {
          return a.orderDate.compareTo(b.orderDate);
        });
        orders[key]['list'].add(order);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    dark = false;
    selectedDate = DateTime.now();
    final ordersList = List.generate(12, (index) {
      return Order(
        deliveryMan: deliveryMen[Random().nextInt(3)],
        price: Random().nextDouble() * 500,
        orderDate: DateTime.now().subtract(
          Duration(
            days: Random().nextInt(12),
            hours: Random().nextInt(24),
            minutes: Random().nextInt(60),
          ),
        ),
      );
    });

    ordersList.forEach((element) {
      final key = DateFormat('yyyyMMdd').format(element.orderDate);
      if (!orders.containsKey(key)) {
        orders[key] = Map<String, dynamic>();
        orders[key]['date'] =
            DateFormat('EEEE, dd/MM/yyyy').format(element.orderDate);
        orders[key]['list'] = SplayTreeSet((Order a, Order b) {
          return a.orderDate.compareTo(b.orderDate);
        });
      }
      orders[key]['list'].add(element);
    });
    String key = DateFormat('yyyyMMdd').format(DateTime.now());
    if (orders.containsKey(key)) {
      selectedOrders = orders[key]['list'];
    } else {
      selectedOrders = null;
    }
  }

  void removeOrder(String key, Order order) {
    setState(() {
      (orders[key]['list'] as SplayTreeSet<Order>).remove(order);
      if (orders[key]['list'].isEmpty) {
        orders.remove(key);
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      body: Stack(
        children: [
          BackgroundContainer(),
          SafeArea(
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  HomeScreenHeader(),
                  Chart(changeSelectedDate, selectedDate, selectedOrders),
                  Expanded(
                    child: NotificationListener<ScrollUpdateNotification>(
                      onNotification: (notification) {
                        if (notification.metrics.pixels > 40 &&
                            showUpButton == false) {
                          setState(() {
                            showUpButton = true;
                          });
                        } else if (notification.metrics.pixels < 40 &&
                            showUpButton == true) {
                          setState(() {
                            showUpButton = false;
                          });
                        }
                        return true;
                      },
                      child: ListView.builder(
                        controller: scrollController,
                        padding: EdgeInsets.only(
                          bottom: kFloatingActionButtonMargin + 56,
                        ),
                        physics: BouncingScrollPhysics(),
                        itemCount: orders.length,
                        itemBuilder: (context, index) {
                          final keys = orders.keys.toList();
                          final currentKey = keys[index];
                          final date = orders[currentKey]['date'];
                          final SplayTreeSet<Order> list =
                              orders[currentKey]['list'];
                          return StickyHeader(
                            header: StickyHeaderHead(date),
                            content: Column(
                              children: list.map((element) {
                                return OrderItem(element, removeOrder);
                              }).toList(),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Container(
        margin: EdgeInsets.only(
          left: 2 * kFloatingActionButtonMargin,
        ),
        child: Row(
          mainAxisAlignment: (showUpButton)
              ? MainAxisAlignment.spaceBetween
              : MainAxisAlignment.end,
          children: [
            if (showUpButton)
              FloatingActionButton(
                mini: true,
                backgroundColor: Colors.grey,
                child: Icon(
                  Icons.keyboard_arrow_up,
                  color: Colors.white,
                ),
                onPressed: () {
                  scrollController.jumpTo(0.0);
                },
              ),
            Spacer(),
            Switch.adaptive(
              value: dark,
              onChanged: (value) {
                setState(() {
                  dark = value;
                });
                widget.toggleTheme();
              },
            ),
            FloatingActionButton(
              backgroundColor: Theme.of(context).primaryColor,
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (BuildContext context) {
                    return AddOrderSheet(deliveryMen, addOrder);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
