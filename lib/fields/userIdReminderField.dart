import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class userIdReminderField extends StatefulWidget {
  late userIdReminderFieldState state;
  @override
  State<userIdReminderField> createState() {
    // TODO: implement createState
    state = userIdReminderFieldState();
    return state;
  }
}

class userIdReminderFieldState extends State<userIdReminderField> {
  bool visible = false;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Visibility(
      visible: visible,
      child: Text(
        'User ID already in used',
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
