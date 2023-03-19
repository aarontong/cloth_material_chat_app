import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OTPverificationText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Expanded(
        child: TextFormField(
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          filled: true,
          hintStyle: TextStyle(color: Colors.grey[800]),
          hintText: "输入验证码",
          fillColor: Colors.white70),
    ));
  }
}
