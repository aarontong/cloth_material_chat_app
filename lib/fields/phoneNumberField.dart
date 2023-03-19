import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';

import '../constant.dart';

class phoneNumberField extends StatelessWidget {
  static final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Expanded(
        child: FocusScope(
            onFocusChange: (value) {
              if (!value) {
                checkAndUpdate(myController.text);
                ;
              }
            },
            child: TextFormField(
              controller: myController,
              onFieldSubmitted: (text) {
                checkAndUpdate(text);
              },
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  filled: true,
                  hintStyle: TextStyle(color: Colors.grey[800]),
                  hintText: "Type in your phone number",
                  fillColor: Colors.white70),
            )));
  }

  Future<void> checkAndUpdate(String text) async {
    PostgreSQLConnection connection = new PostgreSQLConnection(
        Constant.dbHost, Constant.dbPort, Constant.dbName,
        username: "root", password: Constant.dbPassword);
    await connection.open();
    int numRows = await connection.execute(
        'select * from users where phonenumber=@phoneparam',
        substitutionValues: {"phoneparam": '${text}'});
    connection.close();
    print("hello");
  }
}
