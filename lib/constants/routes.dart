import 'package:chatapp/add_friends/add_friends_screen.dart';
import 'package:chatapp/chat_screen/chat_screen.dart';
import 'package:chatapp/chat_screen/screens_bar.dart';

import 'package:chatapp/multiuserchats/multi_user_screens.dart';
import 'package:chatapp/otp_screen/otp_screen.dart';
import 'package:chatapp/otp_screen/take_profile_image.dart';
import 'package:chatapp/sign_up_screen/sign_up_screen.dart';
import 'package:chatapp/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';

Map<String, Widget Function(BuildContext context)> routes = {
  SplashScreen.routeNames: (context) => SplashScreen(),
  SignUpScreen.routeNames: (context) => SignUpScreen(),
  OtpScreen.routeNames: (context) => OtpScreen(),
  ChatScreen.routeNames: (context) => ChatScreen(),
  TakeImage.routeNames: (context) => TakeImage(),
  ScreensBar.routName: (context) => ScreensBar(),
  MultiUserChats.routeNames: (context) => MultiUserChats(),
  AddFriendScreen.routeName: (context) => AddFriendScreen(),
};
