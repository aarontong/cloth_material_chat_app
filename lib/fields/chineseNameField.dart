import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class chineseNameField extends StatelessWidget {
  static final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Expanded(
        child: FocusScope(
            onFocusChange: (value) {
              if (!value) {
                checkAndUpdate();
              }
            },
            child: TextFormField(
              controller: myController,
              onFieldSubmitted: (text) {
                checkAndUpdate();
              },
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  filled: true,
                  hintStyle: TextStyle(color: Colors.grey[800]),
                  hintText: "Type in Chinese Name",
                  fillColor: Colors.white70),
            )));
  }

  void checkAndUpdate() {}
}
