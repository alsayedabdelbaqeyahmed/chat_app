import 'package:chatapp/constants/constants.dart';
import 'package:chatapp/messeges/send_messeges_form.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'messege_container.dart';

class MessegesScreen extends StatelessWidget {
  final String? userId, currentUserId;
  const MessegesScreen({Key? key, this.userId, this.currentUserId})
      : super(key: key);
  static String createdAt = '0';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.only(
        bottom: size.height * 0.02,
        // left: size.height * 0.01,
        // right: size.height * 0.01,
      ),
      child: Column(
        children: [
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection(conChatCollectios)
                .orderBy(conChatCreatedAt, descending: true)
                .snapshots(),
            builder: (ctx, data) {
              if (data.connectionState == ConnectionState.waiting) {
                return Expanded(
                  child: Center(),
                );
              }

              final messegeData = (data.data as QuerySnapshot).docs;

              return messegeData.isEmpty
                  ? Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/welcome.png',
                            width: size.height * 0.15,
                          ),
                          SizedBox(height: size.height * 0.02),
                          Text(
                            'Start chating now',
                            style: TextStyle(
                              fontSize: size.height * 0.04,
                              color: textColor,
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
                          final dates = DateTime.fromMillisecondsSinceEpoch(
                            messegeData[index][conChatCreatedAt]
                                .millisecondsSinceEpoch,
                          );
                          final dateFormat = DateFormat.Hm();
                          final dateString = dateFormat.format(dates);

                          return MessegeContainer(
                            messgeg: messegeData[index][conChatMesseges],
                            isMe: FirebaseAuth.instance.currentUser!.uid ==
                                messegeData[index][conUserId],
                            userName: messegeData[index][conuserName],
                            date: dateString,
                            isUser: messegeData[index][conChatUserId] == userId,
                          );
                        },
                      ),
                    );
            },
          ),
          SendMessegesForm(chatUserId: userId),
        ],
      ),
    );
  }
}
