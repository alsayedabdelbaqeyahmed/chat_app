import 'package:chatapp/constants/constants.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatScreenProvider with ChangeNotifier {
  final _chatAuth = FirebaseFirestore.instance;

  Future<void> addMesseges(
      String? messeges, String userId, String? userName, chatUserId) async {
    _chatAuth.collection(conChatCollectios).doc().set(
      {
        conUserId: userId,
        conChatMesseges: messeges,
        conuserName: userName,
        conChatCreatedAt: Timestamp.now(),
        conChatUserId: chatUserId,
      },
    );
  }
}
