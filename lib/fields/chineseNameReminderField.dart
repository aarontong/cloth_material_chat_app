import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class chineseNameReminderField extends StatefulWidget {
  late ChineseNameReminderFieldState state;
  @override
  State<chineseNameReminderField> createState() {
    // TODO: implement createState
    state = ChineseNameReminderFieldState();
    return state;
  }
}

class ChineseNameReminderFieldState extends State<chineseNameReminderField> {
  bool visible = false;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Visibility(
      visible: visible,
      child: Text(
        'Chinese name already in used',
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
