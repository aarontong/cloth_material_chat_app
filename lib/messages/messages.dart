import 'dart:developer';

import 'package:tencent_cloud_chat_uikit/tencent_cloud_chat_uikit.dart';

class messages {
  Future<void> sendMessage() async {
    // Create a text message
    V2TimValueCallback<V2TimMsgCreateInfoResult> createTextAtMessageRes =
        await TencentImSDKPlugin.v2TIMManager
            .getMessageManager()
            .createTextMessage(
              text: "test fsadfasdfdasafsd",
            );
    if (createTextAtMessageRes.code == 0) {
      String id = createTextAtMessageRes.data!.id!;

      log('created id = ${id}');

      // Send the text message
      V2TimValueCallback<V2TimMessage> sendMessageRes = await TencentImSDKPlugin
          .v2TIMManager
          .getMessageManager()
          .sendMessage(id: id, receiver: 'aaronTesting', groupID: '');
      if (sendMessageRes.code == 0) {
        log('success');
        log('message sent ${sendMessageRes.data!.msgID}');
      } else {
        log('message sent failed ${sendMessageRes.toJson().toString()}');
      }
    }
  }
}
