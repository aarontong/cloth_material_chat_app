import 'package:postgres/postgres.dart';

import '../constant.dart';

class databaseUserOperation {
  static Future<void> registerUser(int vercode) async {
    PostgreSQLConnection connection = new PostgreSQLConnection(
        Constant.dbHost, Constant.dbPort, Constant.dbName,
        username: "root", password: Constant.dbPassword);

    await connection.open();

    final data = <String, dynamic>{
      "userid": "aarontong",
      "cname": "唐伟轩",
      "emailaddr": "aarontongwh@gmail.com",
      "phonenumber": 423895734,
      "password": "3454334",
      "vercode": vercode,
      "verified": false
    };

    await connection.execute(
        'INSERT INTO users (${data.keys.join(', ')}) VALUES (${data.keys.map((k) => '@$k').join(', ')})',
        substitutionValues: data);
    connection.close();
  }
}
