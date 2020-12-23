import 'package:flutter/material.dart';
import 'package:my_shop/providers/user_provider.dart';
import 'package:provider/provider.dart';

class AgreementDialog extends StatefulWidget {
  @override
  _AgreementDialogState createState() => _AgreementDialogState();
}

class _AgreementDialogState extends State<AgreementDialog> {
  bool agreement, flutter;
  ScrollController controller;
  @override
  void initState() {
    super.initState();
    agreement = flutter = false;
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
      title: Text('Switch Account'),
      content: Column(
        children: [
          Expanded(
            child: Scrollbar(
              isAlwaysShown: true,
              controller: controller,
              child: SingleChildScrollView(
                controller: controller,
                padding: EdgeInsets.only(right: 10),
                child: Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean hendrerit gravida nunc, in semper nibh interdum sed. Ut ultrices tempus dictum. Nunc et metus egestas, efficitur erat nec, dignissim justo. Nulla a velit sit amet augue aliquet feugiat. Aliquam erat volutpat. In hac habitasse platea dictumst. Vestibulum dapibus tortor sit amet mi tristique iaculis nec id urna. Vestibulum mattis lorem ipsum, eget iaculis libero accumsan a. Maecenas et sapien nulla. Praesent venenatis feugiat sem eget ultrices. In in sapien varius, volutpat ex mollis, tristique dui. Quisque accumsan eros nulla. Cras ullamcorper ligula urna, in laoreet lectus imperdiet sit amet. Curabitur feugiat, est sed commodo commodo, sem diam vehicula erat, et mollis justo metus eleifend dolor. Nulla ac ornare augue, non molestie justo.\nAenean imperdiet tincidunt dui a imperdiet. Phasellus et tempus sem. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer id purus sit amet nunc consequat semper. Nunc finibus justo ante, ac facilisis eros dictum quis. Suspendisse malesuada finibus libero, eget semper velit. Quisque commodo ligula sed tortor facilisis aliquam. Donec pharetra vestibulum varius. Cras vel luctus lectus. Nullam dictum neque sit amet efficitur sagittis. Nunc feugiat, felis vel sollicitudin pretium, ex est varius diam, vitae tristique dui dolor at massa. Pellentesque eget dui eleifend, rhoncus neque eu, vehicula dui. Maecenas nec nisi eu sem aliquet venenatis. Nunc ante lorem, iaculis ut enim in, sodales varius odio. Fusce ante dolor, dictum a arcu a, posuere tincidunt nunc.\nNam consectetur lectus nec augue mattis varius. Proin eu eleifend sapien, a facilisis augue. Praesent placerat consequat magna, eget rhoncus purus auctor et. Donec eu dolor euismod, semper orci ac, euismod orci. Morbi dictum lectus varius neque iaculis laoreet. Morbi volutpat orci a velit elementum, tristique interdum enim tempor. Integer et urna neque. Pellentesque sit amet tristique quam. Aliquam leo purus, consectetur vel quam consectetur, maximus hendrerit ante. Vivamus faucibus ullamcorper felis quis aliquam. Nulla facilisi. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus felis magna, convallis ac augue auctor, ornare pellentesque metus. Ut sollicitudin mauris eu cursus faucibus.',
                ),
              ),
            ),
          ),
          ListTile(
            leading: Checkbox(
              value: agreement,
              onChanged: (value) {
                setState(() {
                  agreement = !agreement;
                });
              },
            ),
            title: Text('I accept the agreement.'),
            onTap: () {
              setState(() {
                agreement = !agreement;
              });
            },
          ),
          ListTile(
            leading: Checkbox(
              value: flutter,
              onChanged: (value) {
                setState(() {
                  flutter = !flutter;
                });
              },
            ),
            title: Text('I love flutter.'),
            onTap: () {
              setState(() {
                flutter = !flutter;
              });
            },
          ),
        ],
      ),
      actions: [
        RaisedButton(
          color: Colors.black,
          onPressed: (agreement && flutter)
              ? () async {
                  bool noError =
                      await Provider.of<UserProvider>(context, listen: false)
                          .switchUserType();
                  if (noError) {
                    Navigator.of(context).pop();
                  } else {
                    showDialog(
                      context: context,
                      child: AlertDialog(
                        title: Text('Error has occurred'),
                        content: Text('Try again later.'),
                        actions: [
                          FlatButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Ok'),
                          ),
                        ],
                      ),
                    );
                  }
                }
              : null,
          child: Text(
            'Switch',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
