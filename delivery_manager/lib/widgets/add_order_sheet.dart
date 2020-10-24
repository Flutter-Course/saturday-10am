import 'package:delivery_manager/models/order.dart';
import 'package:delivery_manager/widgets/bottom_sheet_title.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddOrderSheet extends StatefulWidget {
  final List<String> deliveryMen;
  final Function addOrder;
  AddOrderSheet(this.deliveryMen, this.addOrder);
  @override
  _AddOrderSheetState createState() => _AddOrderSheetState();
}

class _AddOrderSheetState extends State<AddOrderSheet> {
  String selectedDeliveryMen;
  DateTime selectedDate;
  TextEditingController priceController;
  @override
  void initState() {
    super.initState();
    selectedDeliveryMen = widget.deliveryMen[0];
    selectedDate = DateTime.now();
    priceController = TextEditingController();
  }

  @override
  void dispose() {
    priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).accentColor,
      width: MediaQuery.of(context).size.width,
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              color: Theme.of(context).primaryColor,
              child: Text(
                'Let\'s add an order',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BottomSheetTitle('Who\'ll deliver?'),
                  Card(
                    color: Colors.blue[100],
                    elevation: 5,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          isExpanded: true,
                          value: selectedDeliveryMen,
                          items: widget.deliveryMen.map((e) {
                            return DropdownMenuItem(
                              child: Text(e),
                              value: e,
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedDeliveryMen = value;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  BottomSheetTitle('When\'ll be delivered?'),
                  Row(
                    children: [
                      RaisedButton(
                        color: Colors.blue[100],
                        child: Text(
                          DateFormat('EEEE, dd/MM/yyyy').format(selectedDate),
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        onPressed: () async {
                          DateTime pickedDate = await showDatePicker(
                            context: context,
                            initialDate: selectedDate,
                            firstDate: DateTime.now().subtract(
                              Duration(days: 7),
                            ),
                            lastDate: DateTime.now().add(
                              Duration(days: 90),
                            ),
                          );
                          if (pickedDate != null) {
                            setState(() {
                              selectedDate = DateTime(
                                pickedDate.year,
                                pickedDate.month,
                                pickedDate.day,
                                selectedDate.hour,
                                selectedDate.minute,
                              );
                            });
                          }
                        },
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: Text('at'),
                      ),
                      RaisedButton(
                        color: Colors.blue[100],
                        child: Text(
                          DateFormat('hh:mm a').format(selectedDate),
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        onPressed: () async {
                          TimeOfDay time = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.fromDateTime(selectedDate),
                          );
                          if (time != null) {
                            setState(() {
                              selectedDate = DateTime(
                                selectedDate.year,
                                selectedDate.month,
                                selectedDate.day,
                                time.hour,
                                time.minute,
                              );
                            });
                          }
                        },
                      ),
                    ],
                  ),
                  BottomSheetTitle('What\'s the price?'),
                  Card(
                    elevation: 5,
                    color: Colors.blue[100],
                    child: TextField(
                      controller: priceController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Please enter the price',
                        border: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        focusedErrorBorder: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      child: FlatButton(
                        child: Text(
                          'Add order',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        color: Theme.of(context).primaryColor,
                        onPressed: () {
                          try {
                            double price = double.parse(priceController.text);
                            if (price < 0) {
                              throw 'invalid price';
                            }
                            String key =
                                DateFormat('yyyyMMdd').format(selectedDate);
                            Order order = Order(
                              deliveryMan: selectedDeliveryMen,
                              orderDate: selectedDate,
                              price: price,
                            );
                            widget.addOrder(key, order);
                          } catch (error) {
                            if (Theme.of(context).platform ==
                                TargetPlatform.iOS) {
                              showCupertinoDialog(
                                context: context,
                                builder: (context) {
                                  return CupertinoAlertDialog(
                                    title: Text('Invalid price'),
                                    content: Text('Please enter valid price.'),
                                    actions: [
                                      FlatButton(
                                        child: Text('Ok'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            } else {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('Invalid price'),
                                    content: Text('Please enter valid price.'),
                                    actions: [
                                      FlatButton(
                                        child: Text('Ok'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          }
                        },
                      ),
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
