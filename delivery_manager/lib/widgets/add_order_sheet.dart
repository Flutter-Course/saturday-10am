import 'package:flutter/material.dart';

class AddOrderSheet extends StatefulWidget {
  final List<String> deliveryMen;
  AddOrderSheet(this.deliveryMen);
  @override
  _AddOrderSheetState createState() => _AddOrderSheetState();
}

class _AddOrderSheetState extends State<AddOrderSheet> {
  String selectedDeliveryMen;
  @override
  void initState() {
    super.initState();
    selectedDeliveryMen = widget.deliveryMen[0];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
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
          DropdownButton(
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
        ],
      ),
    );
  }
}
