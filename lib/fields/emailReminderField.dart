import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class emailReminderField extends StatefulWidget {
  late emailReminderFieldState state;
  @override
  State<emailReminderField> createState() {
    // TODO: implement createState
    state = emailReminderFieldState();
    return state;
  }
}

class emailReminderFieldState extends State<emailReminderField> {
  bool visible = false;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Visibility(
      visible: visible,
      child: Text(
        'Email already in used',
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
