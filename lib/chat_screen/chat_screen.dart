import 'package:chatapp/chat_screen/chat_app_bar.dart';
import 'package:chatapp/chat_screen/screens_bar.dart';

import 'package:chatapp/messeges/messeges.dart';

import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  static const String routeNames = 'chat-screen';
  final String? currentUserId, userId, userName, friendPhone, userphone;

  ChatScreen(
      {this.currentUserId,
      this.userId,
      this.userName,
      this.friendPhone,
      this.userphone});

  Widget build(BuildContext context) {
    // print(userElement);
    final chatId = friendPhone! + userphone!;
    final friendChatId = userphone! + friendPhone!;
    return Scaffold(
      body: Column(
        children: [
          ChatAppBar(
            userphone: userphone,
          ),
          ScreensBar(userName: userName == '' ? friendPhone : userName),
          Expanded(
            child: MessegesScreen(
              friendUserId: userId,
              currentUserId: currentUserId,
              friendPhone: friendPhone,
              chatId: chatId,
              friendChatId: friendChatId,
              myPhone: userphone,
            ),
          ),
        ],
      ),
    );
  }
}
