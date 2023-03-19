import 'dart:math';

import 'package:postgres/postgres.dart';

class Constant {
  static final String secretKey = "rX0LiuteBTXNEQQCukZJuJXcVAg073nK";
  static final String secretId = "IKIDxqtqaBZjjZLxRkqkRvCIG0VmocBW1ILE";
  static final headers = {
    'Content-Type': 'application/x-www-form-urlencoded;',
  };
  static final String request =
      'GETses.tencentcloudapi.com/?Action=GetSendEmailStatus&Limit=0&MessageId=dd&Nonce=0&Offset=0&Region=ap-singapore&RequestDate=dd&SecretId=${secretId}&Timestamp=dd&Version=2020-10-02';
  static final String sendEmailRequest =
      'GETses.tencentcloudapi.com/?Action=SendEmail&Destination.0=dd&FromEmailAddress=QCLOUDTEAM <auto-reply@qqcloth.com>&Nonce=1&Region=ap-singapore&SecretId=${secretId}&Subject=<QQCloth> Registration Code&Template.TemplateData=dd&Template.TemplateID=47399&Timestamp=dd&Version=2020-10-02';
  static final String dbPassword = 'At!7291993';
  static final String dbHost = "bj-postgres-m7f5bof4.sql.tencentcdb.com";
  static final String dbName = "postgres";
  static final int dbPort = 25858;

  static int Generate6digit() {
    var rng = new Random();
    var rand = rng.nextInt(900000) + 100000;
    return rand.toInt();
  }
}
