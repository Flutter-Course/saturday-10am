import 'dart:collection';

import 'package:delivery_manager/models/order.dart';
import 'package:delivery_manager/widgets/chart_bar.dart';
import 'package:delivery_manager/widgets/hero_item.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatefulWidget {
  final Function changeSelectedDate;
  final DateTime selectedDate;
  final SplayTreeSet<Order> orders;

  Chart(this.changeSelectedDate, this.selectedDate, this.orders);

  @override
  _ChartState createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  Map<String, int> data;

  void updateData() {
    data = Map<String, int>();
    if (widget.orders != null) {
      widget.orders.forEach((element) {
        if (data.containsKey(element.deliveryMan)) {
          data[element.deliveryMan]++;
        } else {
          data[element.deliveryMan] = 1;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    updateData();
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 5,
      margin: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.05,
      ).add(
        EdgeInsets.only(
          bottom: 20,
        ),
      ),
      color: Theme.of(context).accentColor,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(8),
        height: MediaQuery.of(context).size.height * 0.3,
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: ListView.builder(
                reverse: true,
                scrollDirection: Axis.horizontal,
                itemCount: 7,
                itemBuilder: (context, index) {
                  DateTime currentDate =
                      DateTime.now().subtract(Duration(days: index));
                  String text = DateFormat('dd/MM').format(currentDate);
                  bool selected =
                      text == DateFormat('dd/MM').format(widget.selectedDate);
                  return Container(
                    margin: EdgeInsets.only(
                        left: index == 6 ? 0 : 2, right: index == 0 ? 0 : 2),
                    child: FlatButton(
                      shape: StadiumBorder(),
                      child: Text(text),
                      color: selected ? Colors.yellow : Colors.amber[100],
                      onPressed: () {
                        widget.changeSelectedDate(currentDate);
                      },
                    ),
                  );
                },
              ),
            ),
            Expanded(
              flex: 8,
              child: (widget.orders == null || widget.orders.length == 0)
                  ? Center(
                      child: Text(
                      'No Orders',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ))
                  : Column(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Row(
                            children: [
                              Text('#Orders'),
                              Expanded(child: Container()),
                              Expanded(
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: [
                                    HeroItem(Colors.blue, 'Muhammed Aly'),
                                    HeroItem(Colors.yellow, 'Toka Ehab'),
                                    HeroItem(Colors.purple, 'Ahmed Aly'),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 8,
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              return Row(
                                children: [
                                  Container(
                                    width: constraints.maxWidth * 0.1,
                                    height: constraints.maxHeight,
                                    decoration: BoxDecoration(
                                      border: Border(
                                        right: BorderSide(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('10'),
                                        Text('5'),
                                        Text('0'),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: constraints.maxWidth * 0.9,
                                    height: constraints.maxHeight,
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        if (data.containsKey('Muhammed Aly'))
                                          ChartBar(
                                            height: data['Muhammed Aly'] *
                                                constraints.maxHeight /
                                                10,
                                            color: Colors.blue,
                                            name: 'Muhammed Aly',
                                            numberOfOrders:
                                                data['Muhammed Aly'],
                                          ),
                                        if (data.containsKey('Toka Ehab'))
                                          ChartBar(
                                            height: data['Toka Ehab'] *
                                                constraints.maxHeight /
                                                10,
                                            color: Colors.yellow,
                                            name: 'Toka Ehab',
                                            numberOfOrders: data['Toka Ehab'],
                                          ),
                                        if (data.containsKey('Ahmed Aly'))
                                          ChartBar(
                                            height: data['Ahmed Aly'] *
                                                constraints.maxHeight /
                                                10,
                                            color: Colors.purple,
                                            name: 'Ahmed Aly',
                                            numberOfOrders: data['Ahmed Aly'],
                                          ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
