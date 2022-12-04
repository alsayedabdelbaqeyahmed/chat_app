import 'package:chatapp/constants/constants.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatScreenProvider with ChangeNotifier {
  final _chatAuth = FirebaseFirestore.instance;
  // static String? friendPhone;
  Future<void> addMesseges({
    BuildContext? context,
    String? messeges,
    String? userId,
    String? userName,
    chatUserId,
    String? userPhone,
    required String? freindPhone,
  }) async {
    final friendUserId = await FirebaseFirestore.instance
        .collection(AppConstansts.conUserCollectios)
        .doc(userPhone)
        .collection(AppConstansts.conFriendCollection)
        .doc(freindPhone)
        .get();
    //  final chatId = friendUserId[conChatId];

    _chatAuth
        .collection(AppConstansts.conUserCollectios)
        .doc(userPhone)
        .collection(AppConstansts.conFriendCollection)
        .doc(freindPhone)
        .collection(AppConstansts.conChatCollectios)
        .doc()
        .set(
      {
        AppConstansts.conUserId: userId,
        AppConstansts.conChatMesseges: messeges,
        AppConstansts.conuserName: userName,
        AppConstansts.conChatCreatedAt: Timestamp.now(),
        AppConstansts.conChatUserId: friendUserId[AppConstansts.conFriendPhone],
        AppConstansts.conFriendUserName: friendUserId[AppConstansts.conFriendUserName] == null
            ? freindPhone
            : friendUserId[AppConstansts.conFriendUserName]
      },
    ).then((value) {
      _chatAuth
          .collection(AppConstansts.conUserCollectios)
          .doc(freindPhone)
          .collection(AppConstansts.conFriendCollection)
          .doc(userPhone)
          .collection(AppConstansts.conChatCollectios)
          .doc()
          .set(
        {
          AppConstansts.conUserId: userId,
          AppConstansts.conChatMesseges: messeges,
          AppConstansts.conuserName: userName,
          AppConstansts.conChatCreatedAt: Timestamp.now(),
          AppConstansts.conChatUserId: friendUserId[AppConstansts.conFriendPhone],
          AppConstansts.conFriendUserName: friendUserId[AppConstansts.conFriendUserName] == null
              ? freindPhone
              : friendUserId[AppConstansts.conFriendUserName]
        },
      );
    });
  }
}
