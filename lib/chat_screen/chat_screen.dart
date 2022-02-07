import 'package:chatapp/chat_screen/chat_app_bar.dart';

import 'package:chatapp/messeges/messeges.dart';

import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  static const String routeNames = 'chat-screen';
  final String? currentUserId, userId, userName;

  ChatScreen({this.currentUserId, this.userId, this.userName});

  Widget build(BuildContext context) {
    // print(userElement);

    return Scaffold(
      body: Column(
        children: [
          ChatAppBar(),
          //ScreensBar(userName: userName),
          Expanded(
            child: MessegesScreen(
              userId: userId,
              currentUserId: currentUserId,
            ),
          ),
        ],
      ),
    );
  }
}
