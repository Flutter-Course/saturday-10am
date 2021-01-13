import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_shop/providers/user_provider.dart';
import 'package:provider/provider.dart';

class AgreementDialog extends StatefulWidget {
  @override
  _AgreementDialogState createState() => _AgreementDialogState();
}

class _AgreementDialogState extends State<AgreementDialog> {
  bool agree, confirm;
  ScrollController controller;
  @override
  void initState() {
    super.initState();
    agree = confirm = false;
    controller = ScrollController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Switch Type'),
      content: Column(
        children: [
          Expanded(
            child: Card(
              elevation: 10,
              margin: EdgeInsets.zero,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Scrollbar(
                  controller: controller,
                  isAlwaysShown: true,
                  child: SingleChildScrollView(
                    controller: controller,
                    padding: EdgeInsets.only(right: 15),
                    child: Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer bibendum dolor id diam imperdiet, sed varius massa pulvinar. Fusce volutpat sapien nec purus lacinia elementum. Praesent et urna a est mattis convallis ac suscipit augue. In mollis at sapien sit amet sollicitudin. Donec ornare orci in facilisis luctus. Donec molestie bibendum orci, vitae gravida nisl sollicitudin at. Fusce laoreet aliquet nulla, a aliquet urna finibus eu. Vivamus quis volutpat sapien, id pretium massa. Fusce luctus, tortor tempus aliquet semper, nibh lectus dapibus dui, mollis vehicula ipsum turpis nec arcu. Nulla facilisi. Curabitur maximus, ex at sodales condimentum, turpis leo blandit dolor, sit amet dapibus lorem enim quis orci.\n\nMaecenas euismod ipsum eget lacus pulvinar, non rutrum lacus consectetur. Nunc rutrum sollicitudin dui, nec tristique ex ullamcorper sed. Duis et consectetur ligula. Quisque sodales orci tincidunt, tempus quam sit amet, accumsan odio. Vestibulum ut dui et purus facilisis accumsan sit amet at enim. Quisque condimentum, nunc at tincidunt egestas, arcu lectus dignissim lectus, at commodo eros lacus eget mi. Nam scelerisque lacus eu varius vulputate. Etiam efficitur velit eleifend, feugiat tortor eget, tristique enim. Nulla at tempus lorem. Etiam eros neque, sollicitudin accumsan tincidunt et, porta sed metus. Aliquam commodo sollicitudin mi. Etiam elit sem, laoreet a massa nec, tempor vestibulum enim. Etiam eu iaculis lacus. In sed nibh nisi.\n\nMaecenas congue malesuada congue. Curabitur ut ultrices arcu, sit amet efficitur neque. Cras varius nulla quis lectus luctus, mollis accumsan lectus pharetra. Nunc aliquam lacus nec orci feugiat maximus. Aliquam egestas dictum risus, vitae dapibus eros. Integer faucibus velit eu lorem pharetra, nec pretium ipsum interdum. Donec facilisis est et diam dictum blandit. Suspendisse vitae nisl quis nunc tristique laoreet ac in sapien. Integer ullamcorper purus in orci finibus, eu pellentesque odio bibendum. Cras quis arcu nec eros congue facilisis eget ut justo. Morbi sit amet dapibus est, at molestie arcu.'),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            onTap: () {
              setState(() {
                agree = !agree;
              });
            },
            leading: Checkbox(
                value: agree,
                onChanged: (value) {
                  setState(() {
                    agree = !agree;
                  });
                }),
            title: Text('I agree.'),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            onTap: () {
              setState(() {
                confirm = !confirm;
              });
            },
            leading: Checkbox(
                value: confirm,
                onChanged: (value) {
                  setState(() {
                    confirm = !confirm;
                  });
                }),
            title: Text('I confirm.'),
          ),
        ],
      ),
      actions: [
        RaisedButton(
          color: Colors.black,
          child: Text(
            'Switch Account',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          onPressed: (agree && confirm)
              ? () async {
                  bool noError =
                      await Provider.of<UserProvider>(context, listen: false)
                          .toggleUserType();
                  if (noError) {
                    Navigator.of(context).pop();
                  } else {
                    //showDialog
                  }
                }
              : null,
        ),
      ],
    );
  }
}
