import 'dart:io';

import 'package:cloth_material_chat_app/fields/chineseNameField.dart';
import 'package:cloth_material_chat_app/fields/emailField.dart';
import 'package:cloth_material_chat_app/fields/emailReminderField.dart';
import 'package:cloth_material_chat_app/fields/phoneNumberField.dart';
import 'package:cloth_material_chat_app/fields/phoneNumberReminderField.dart';
import 'package:cloth_material_chat_app/fields/userIdField.dart';
import 'package:cloth_material_chat_app/fields/userIdReminderField.dart';
import 'package:cloth_material_chat_app/operationLogic/databaseUserOperation.dart';
import 'package:cloth_material_chat_app/pages/OTPPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_alert/flutter_platform_alert.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:postgres/postgres.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:tencent_cloud_chat_uikit/tencent_cloud_chat_uikit.dart';
import 'package:cloth_material_chat_app/constant.dart';

import '../fields/chineseNameReminderField.dart';

class individualRegister extends StatelessWidget {
  static String route = "/individualRegister";
  final _formKey = GlobalKey<FormState>();
  String messageId = "";
  // String templateString =
  //  "{\"TemplateID\":\"47399\",\"TemplateData\":\"{\"verCode\":\"123456789\",\"timeInMin\":\"5\"}\"}";
  int vercode = Constant.Generate6digit();
  Future<Response> sendEmail() async {
    double dateIntDouble = (DateTime.now().millisecondsSinceEpoch) / 1000;
    int nowDate = dateIntDouble.toInt();
    Map<String, dynamic> templateInfo = {
      'verCode': '${vercode}',
      'timeInMin': '5'
    };
    String templatejson = jsonEncode(templateInfo);
    String emailAddr = emailField.myController.text;
    String request = Constant.sendEmailRequest
        .replaceAll('Destination.0=dd', 'Destination.0=${emailAddr}');
    request = request.replaceAll('Timestamp=dd', 'Timestamp=${nowDate}');
    request = request.replaceAll('Template.TemplateData=dd',
        'Template.TemplateData=${templatejson.toString()}');
    List<int> messageBytes = utf8.encode(request);
    List<int> key = utf8.encode(Constant.secretKey);
    Hmac hmac = new Hmac(sha1, key);
    Digest digest = hmac.convert(messageBytes);

    String base64Mac = base64Encode(digest.bytes);
    Map<String, dynamic> paramMap = {
      "Action": "SendEmail",
      "Destination.0": emailAddr,
      "FromEmailAddress": "QCLOUDTEAM <auto-reply@qqcloth.com>",
      "Nonce": "1",
      "Region": "ap-singapore",
      "SecretId": "${Constant.secretId}",
      "Subject": "<QQCloth> Registration Code",
      "Signature": "${base64Mac}",
      "Template.TemplateData": templatejson.toString(),
      "Template.TemplateID": "47399",
      "Timestamp": "${nowDate}",
      "Version": "2020-10-02"
    };
    Uri fullUri = Uri.https('ses.tencentcloudapi.com', '', paramMap);
    String path = fullUri.path;

    String query = fullUri.query;

    http.Response response;
    response = await http.get(fullUri, headers: Constant.headers);
    return response;
  }

  Future<Response> queryEmailStatus(String messageId) async {
    var nowDate = DateTime.now();
    var dt = DateTime.now().millisecondsSinceEpoch;
// 12 Hour format:
    String d12 = new DateFormat("yyyy-MM-dd").format(nowDate);
    String request =
        Constant.request.replaceAll('MessageId=dd', 'MessageId=${messageId}');
    request = request.replaceAll('RequestDate=dd', 'RequestDate=${d12}');
    request =
        request.replaceAll('Timestamp=dd', 'Timestamp=${(dt / 1000).toInt()}');

    List<int> messageBytes = utf8.encode(request);
    List<int> key = utf8.encode(Constant.secretKey);
    Hmac hmac = new Hmac(sha1, key);
    Digest digest = hmac.convert(messageBytes);

    String base64Mac = base64Encode(digest.bytes);
    Map<String, dynamic> paramMap = {
      "Action": "GetSendEmailStatus",
      "Limit": "0",
      "Offset": "0",
      "MessageId": messageId,
      "Nonce": "0",
      "Region": "ap-singapore",
      "RequestDate": "${d12}",
      "SecretId": "${Constant.secretId}",
      "Signature": "${base64Mac}",
      "Timestamp": "${(dt / 1000).toInt()}",
      "Version": "2020-10-02"
    };
    Uri fullUri = Uri.https('ses.tencentcloudapi.com', '', paramMap);
    String path = fullUri.path;

    String query = fullUri.query;

    http.Response response;
    response = await http.get(fullUri, headers: Constant.headers);
    return response;
  }

  @override
  Widget build(BuildContext context) {
    chineseNameReminderField cnrf = chineseNameReminderField();
    phoneNumberReminderField pnrf = phoneNumberReminderField();
    emailReminderField erf = emailReminderField();
    userIdReminderField uirf = userIdReminderField();

    // TODO: implement build
    /*
    return PlayAnimationBuilder<Color?>(
      // <-- animate integers
      tween: ColorTween(begin: Colors.red, end: Colors.blue), // define tween
      duration: const Duration(seconds: 1),
      builder: (_, Color? color, value) {
        */
    return Scaffold(
        body: Form(
      key: _formKey,
      child: Center(
          child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              children: [
                Text(
                  '中文名称: ',
                  style: TextStyle(fontSize: 18),
                ),
                chineseNameField()
              ],
            ),
            SizedBox(
              height: 5,
              child: const DecoratedBox(
                decoration: const BoxDecoration(color: Colors.red),
              ),
            ),
            Row(
              children: [cnrf],
            ),
            SizedBox(
              height: 5,
              child: const DecoratedBox(
                decoration: const BoxDecoration(color: Colors.red),
              ),
            ),
            Row(
              children: [
                Text(
                  '帐户名称: ',
                  style: TextStyle(fontSize: 18),
                ),
                userIdField(),
              ],
            ),
            SizedBox(
              height: 5,
              child: const DecoratedBox(
                decoration: const BoxDecoration(color: Colors.red),
              ),
            ),
            Row(
              children: [uirf],
            ),
            SizedBox(
              height: 5,
              child: const DecoratedBox(
                decoration: const BoxDecoration(color: Colors.red),
              ),
            ),
            Row(
              children: [
                Text(
                  '电邮地址: ',
                  style: TextStyle(fontSize: 18),
                ),
                emailField(),
              ],
            ),
            SizedBox(
              height: 5,
              child: const DecoratedBox(
                decoration: const BoxDecoration(color: Colors.red),
              ),
            ),
            Row(
              children: [erf],
            ),
            SizedBox(
              height: 5,
              child: const DecoratedBox(
                decoration: const BoxDecoration(color: Colors.red),
              ),
            ),
            Row(
              children: [
                Text(
                  '电话号码: ',
                  style: TextStyle(fontSize: 18),
                ),
                phoneNumberField(),
              ],
            ),
            SizedBox(
              height: 5,
              child: const DecoratedBox(
                decoration: const BoxDecoration(color: Colors.red),
              ),
            ),
            Row(
              children: [pnrf],
            ),
            SizedBox(
              height: 5,
              child: const DecoratedBox(
                decoration: const BoxDecoration(color: Colors.red),
              ),
            ),
            Row(
              children: [
                Text(
                  '输入新密码: ',
                  style: TextStyle(fontSize: 18),
                ),
                Expanded(
                    child: TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      filled: true,
                      hintStyle: TextStyle(color: Colors.grey[800]),
                      hintText: "Type in your text",
                      fillColor: Colors.white70),
                )),
              ],
            ),
            SizedBox(
              height: 10,
              child: const DecoratedBox(
                decoration: const BoxDecoration(color: Colors.red),
              ),
            ),
            Row(
              children: [
                Text(
                  '重新输入密码: ',
                  style: TextStyle(fontSize: 18),
                ),
                Expanded(
                    child: TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      filled: true,
                      hintStyle: TextStyle(color: Colors.grey[800]),
                      hintText: "Type in your text",
                      fillColor: Colors.white70),
                )),
              ],
            ),
            SizedBox(
              height: 10,
              child: const DecoratedBox(
                decoration: const BoxDecoration(color: Colors.red),
              ),
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: TextButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.red),
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        minimumSize: MaterialStateProperty.all<Size>(
                            Size.fromHeight(50))),
                    child: const Text('Clear'),
                    onPressed: () {
                      _formKey.currentState!.reset();
                    },
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: TextButton(
                    child: const Text('Confirm'),
                    onPressed: () async {
                      /* Send Email
                      Response emailRespond = await sendEmail();
                      String respondBody = emailRespond.body;
                      Map<String, dynamic> responseJson =
                          jsonDecode(respondBody);
                      Map<String, dynamic> response2 = responseJson["Response"];
                      if (emailRespond.statusCode != 200 ||
                          response2.containsKey("Error")) {
                        Map<String, dynamic> errorMap = response2["Error"];
                        showAlertDialog(context, errorMap["Message"]);
                      } else {
                        */

                      try {
                        await databaseUserOperation.registerUser(vercode);
                      } catch (error) {
                        return;
                      }
                      PostgreSQLConnection connection =
                          new PostgreSQLConnection(
                              Constant.dbHost, Constant.dbPort, Constant.dbName,
                              username: "root", password: Constant.dbPassword);
                      await connection.open();
                      final data = <String, dynamic>{
                        "userid": "aarontong",
                        "cname": "唐伟轩",
                        "emailaddr": "aarontongwh@gmail.com",
                        "phonenumber": 423895734,
                        "password": "3454334",
                      };

                      await connection.execute(
                          'INSERT INTO users (${data.keys.join(', ')}) VALUES (${data.keys.map((k) => '@$k').join(', ')})',
                          substitutionValues: data);

                      /*     
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (_, __, ___) => OTPPage(),
                          transitionDuration: Duration(seconds: 1),
                          transitionsBuilder: (_, a, __, c) =>
                              FadeTransition(opacity: a, child: c),
                        ),
                      );

                      */
                      // }
                    },
                  ),
                )
              ],
            ),
          ],
        ),
      )),
    ));
    //},
    // );
  }

  showAlertDialog(BuildContext context, String errorMsg) {
    // Init
    FlutterPlatformAlert.showAlert(
      windowTitle: 'Email Not Delivered',
      text: errorMsg,
      alertStyle: AlertButtonStyle.ok,
      iconStyle: IconStyle.information,
    );
  }
}
