import 'package:chatapp/constants/constants.dart';
import 'package:chatapp/constants/userDataModel.dart';
import 'package:chatapp/messeges/send_messeges_form.dart';
import 'package:chatapp/presentation/style/app_assets.dart';
import 'package:chatapp/presentation/style/app_string.dart';
import 'package:chatapp/presentation/style/app_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'messege_container.dart';

class MessegesScreen extends StatefulWidget {
  final String? friendUserId,
      currentUserId,
      friendPhone,
      chatId,
      friendChatId,
      myPhone;
  const MessegesScreen({
    Key? key,
    this.friendUserId,
    this.currentUserId,
    required this.friendPhone,
    this.chatId,
    this.friendChatId,
    this.myPhone,
  }) : super(key: key);
  static String createdAt = '0';

  @override
  State<MessegesScreen> createState() => _MessegesScreenState();
}

class _MessegesScreenState extends State<MessegesScreen> {
  UserDataModel? user;
  // String? localUserPhone;
  String? localUserName;

  var db = LocalDataBase.db;
  Future<UserDataModel> userData() async {
    await db.getUserData().then((value) {
      // print(value);
      // value.map((e) {
      //   localUserName = e.username;
      //   localUserPhone = e.userPhone2;
      // });
      user = value;
      return user;
    });
    return user!;
  }

  // @override
  // void initState() {
  //  // var fcm = FirebaseMessaging.instance;
  //   // var token = fcm.getToken();
  //   // print(token.toString());
  //   //fcm.subscribeToTopic("messages");

  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.only(
        bottom: size.height * 0.02,
        // left: size.height * 0.01,
        // right: size.height * 0.01,
      ),
      child: FutureBuilder(
          future: userData(),
          builder: (context, data) {
            return data.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    children: [
                      StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection(AppConstansts.conUserCollectios)
                            .doc(user!.userPhone2)
                            .collection(AppConstansts.conFriendCollection)
                            .doc(widget.friendPhone)
                            .collection(AppConstansts.conChatCollectios)
                            .orderBy(AppConstansts.conChatCreatedAt,
                                descending: true)
                            .snapshots(),
                        builder: (ctx, data) {
                          if (data.connectionState == ConnectionState.waiting) {
                            return Expanded(
                              child: Center(),
                            );
                          }

                          final List? messegeData =
                              (data.data as QuerySnapshot).docs;
                          // print(messegeData!.isEmpty);

                          return messegeData!.isEmpty
                              ? Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        AppAssetsConstants.welcome,
                                        width: size.height * 0.15,
                                      ),
                                      SizedBox(height: size.height * 0.02),
                                      Text(
                                        AppStringConstants.startChat,
                                        style: TextStyle(
                                          fontSize: size.height * 0.04,
                                          color: AppColors.textColor,
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              : Expanded(
                                  child: ListView.builder(
                                    reverse: true,
                                    itemCount: messegeData.length,
                                    itemBuilder: (ctx, index) {
                                      final dates =
                                          DateTime.fromMillisecondsSinceEpoch(
                                        messegeData[index]
                                                [AppConstansts.conChatCreatedAt]
                                            .millisecondsSinceEpoch,
                                      );
                                      final dateFormat = DateFormat.Hm();
                                      final dateString =
                                          dateFormat.format(dates);

                                      return MessegeContainer(
                                        userPhone: user!.userPhone2,
                                        messgeg: messegeData[index]
                                            [AppConstansts.conChatMesseges],
                                        isMe: FirebaseAuth
                                                .instance.currentUser!.uid ==
                                            messegeData[index]
                                                [AppConstansts.conUserId],
                                        userName: messegeData[index]
                                            [AppConstansts.conuserName],
                                        date: dateString,
                                        isUser: messegeData[index]
                                                [AppConstansts.conChatUserId] ==
                                            widget.friendUserId,
                                      );
                                    },
                                  ),
                                );
                        },
                      ),
                      SendMessegesForm(
                        chatUserId: widget.friendUserId,
                        userPhone: user!.userPhone2,
                        friendPhone: widget.friendPhone,
                      ),
                    ],
                  );
          }),
    );
  }
}
