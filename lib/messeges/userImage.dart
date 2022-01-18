import 'package:chatapp/constants/constants.dart';
import 'package:flutter/material.dart';

Container userImage(Size size, String data, bool isMe, {bool isChat = false}) {
  return Container(
    margin: EdgeInsets.only(bottom: size.height * 0.01),
    width: size.height * 0.068,
    height: size.height * 0.068,
    padding: EdgeInsets.all(size.height * 0.006),
    decoration: BoxDecoration(
      color: isMe ? Color(0xffFFC7F9) : Color(0xffDCB471),
      borderRadius: isChat
          ? BorderRadius.all(Radius.circular(size.height * 0.05))
          : BorderRadius.only(
              topLeft: isMe
                  ? Radius.circular(size.height * 0.05)
                  : Radius.circular(0),
              bottomLeft: isMe
                  ? Radius.circular(size.height * 0.05)
                  : Radius.circular(0),
              topRight: !isMe
                  ? Radius.circular(size.height * 0.05)
                  : Radius.circular(0),
              bottomRight: !isMe
                  ? Radius.circular(size.height * 0.05)
                  : Radius.circular(0),
            ),
    ),
    child: CircleAvatar(
      backgroundImage: NetworkImage(
        data,
      ),
    ),
  );
}
