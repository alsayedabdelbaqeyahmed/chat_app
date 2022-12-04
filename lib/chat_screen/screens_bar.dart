import 'package:chatapp/constants/constants.dart';
import 'package:chatapp/presentation/style/app_theme.dart';

import 'package:flutter/material.dart';

class ScreensBar extends StatelessWidget {
  static const routName = 'chat-screen-bar';
  final String? userName;

  const ScreensBar({Key? key, this.userName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(top: size.height * 0.03),
      color: AppColors.primaryColor,
      height: size.height * 0.09,
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.only(left: size.width * 0.03),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            chatRowText(userName!, size),
          ],
        ),
      ),
    );
  }

  Widget chatRowText(String text, Size size) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size.height * 0.03,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
