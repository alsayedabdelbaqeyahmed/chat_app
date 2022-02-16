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
        .collection(conUserCollectios)
        .doc(userPhone)
        .collection(conFriendCollection)
        .doc(freindPhone)
        .get();

    _chatAuth
        .collection(conUserCollectios)
        .doc(userPhone)
        .collection(conFriendCollection)
        .doc(freindPhone)
        .collection(conChatCollectios)
        .doc()
        .set(
      {
        conUserId: userId,
        conChatMesseges: messeges,
        conuserName: userName,
        conChatCreatedAt: Timestamp.now(),
        conChatUserId: friendUserId[conFriendPhone],
        conFriendUserName: friendUserId[conFriendUserName] == null
            ? freindPhone
            : friendUserId[conFriendUserName]
      },
    ).then((value) {
      _chatAuth
          .collection(conUserCollectios)
          .doc(freindPhone)
          .collection(conFriendCollection)
          .doc(userPhone)
          .collection(conChatCollectios)
          .doc()
          .set(
        {
          conUserId: userId,
          conChatMesseges: messeges,
          conuserName: userName,
          conChatCreatedAt: Timestamp.now(),
          conChatUserId: friendUserId[conFriendPhone],
          conFriendUserName: friendUserId[conFriendUserName] == null
              ? freindPhone
              : friendUserId[conFriendUserName]
        },
      );
    });
  }
}
