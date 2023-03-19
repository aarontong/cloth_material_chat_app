import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class phoneNumberReminderField extends StatefulWidget {
  late phoneNumberReminderFieldState state;
  @override
  State<phoneNumberReminderField> createState() {
    // TODO: implement createState
    state = phoneNumberReminderFieldState();
    return state;
  }
}

class phoneNumberReminderFieldState extends State<phoneNumberReminderField> {
  bool visible = false;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Visibility(
      visible: visible,
      child: Text(
        'Phone Number already in used',
        textAlign: TextAlign.right,
        style: TextStyle(color: Colors.brown, fontSize: 10),
      ),
    );
  }

  void setVisibility(bool visible) {
    setState(() {
      this.visible = visible;
    });
  }
}
