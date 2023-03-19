import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tencent_cloud_chat_uikit/tencent_cloud_chat_uikit.dart';

import 'dart:developer';

class messageUser {
  Future<void> addUserToChat(String userid) async {
    String url =
        'https://adminapisgp.im.qcloud.com/v4/im_open_login_svc/account_import?sdkappid=20002036&identifier=administrator&usersig=eJwtzF0LgjAYBeD-8t4WumZzIngVREKBZUKFN4MtfQs-2IaF0X8vPy7Pcw7nA*d96nRKQwjUIbAcM0pVW7zjyEJWWKOxWthGzwMjn6JtUUJICSGUeP7k6t2iVhCuGGNDM6nFajCf8zX1eDCrweL-fumuVe6al9iW6U3rMu6zWNbHnSizJAnShizU4dRnm*KRu0EE3x*GSzWu&random=99999999&contenttype=json';
    List data;
    bool _isDataLoading = true;

    var response = await http.post(Uri.parse(url),
        headers: {"Accept": 'application/json'},
        body: jsonEncode(<String, String>{
          'UserID': '${userid}',
        }));

    var listData = json.decode(response.body);
    data = listData['results'];

    _isDataLoading = false;

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
  }

  void loginUser() {
    final CoreServicesImpl _coreInstance = TIMUIKitCore.getInstance();

    _coreInstance
        .login(
            userID: 'administrator',
            userSig:
                'eJwtzF0LgjAYBeD-8t4WumZzIngVREKBZUKFN4MtfQs-2IaF0X8vPy7Pcw7nA*d96nRKQwjUIbAcM0pVW7zjyEJWWKOxWthGzwMjn6JtUUJICSGUeP7k6t2iVhCuGGNDM6nFajCf8zX1eDCrweL-fumuVe6al9iW6U3rMu6zWNbHnSizJAnShizU4dRnm*KRu0EE3x*GSzWu')
        .then((value) {
      log('${value.toJson()}');
    });
  }
}
