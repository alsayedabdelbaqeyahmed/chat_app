import 'dart:math';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:chatapp/chat_screen/chat_screen.dart';
import 'package:chatapp/constants/constants.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

class AddFriendProvider with ChangeNotifier {
  final _friendAuth = FirebaseFirestore.instance;

  Future<void> addFriends({
    required String? friendName,
    required String? friendNumber,
    required userPhone,
    BuildContext? context,
  }) async {
    final friendUser = await FirebaseFirestore.instance
        .collection(conUserCollectios)
        .doc(friendNumber)
        .get();
    final currentUser = await FirebaseFirestore.instance
        .collection(conUserCollectios)
        .doc(userPhone)
        .get();

    final users =
        await FirebaseFirestore.instance.collection(conUserCollectios).get();
    final userList = users.docs.map((e) => e.data()).toList();

    final element = userList.firstWhere(
      (element) => element[conuserPhone] == friendNumber,
      orElse: () => {},
    );
    // print(element[conuserPhone]);
    // print(userPhone);
    // print(element[conuserPhone] == userPhone);
    if (element[conuserPhone] == userPhone || element.isEmpty) {
      AwesomeDialog(
              padding: EdgeInsets.all(10),
              context: context!,
              dialogType: DialogType.ERROR,
              body: Column(children: [
                element[conuserPhone] != userPhone
                    ? Text(
                        'the user is not found',
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      )
                    : Text(
                        'يعم ده انت ',
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                SizedBox(height: 20),
                element[conuserPhone] != userPhone
                    ? Text(
                        'invite your friend \n to use our app',
                        style: TextStyle(color: Colors.red, fontSize: 15),
                      )
                    : Text(
                        'بلاش هزارك الرخم ده',
                        style: TextStyle(color: Colors.red, fontSize: 15),
                      ),
              ]),
              btnOkText: 'Cancel',
              btnOkOnPress: () {})
          .show();
    } else {
      _friendAuth
          .collection(conUserCollectios)
          .doc(userPhone)
          .collection(conFriendCollection)
          .doc(friendNumber)
          .set(
        {
          conFriendUserName: friendName,
          conFriendPhone: friendNumber,
          conUserImageUrl: friendUser[conUserImageUrl],
          conFriendId: friendUser[conUserId],
        },
      ).then((value) {
        _friendAuth
            .collection(conUserCollectios)
            .doc(friendNumber)
            .collection(conFriendCollection)
            .doc(userPhone)
            .set(
          {
            conFriendUserName: '',
            conFriendPhone: userPhone,
            conUserImageUrl: currentUser[conUserImageUrl],
            conFriendId: currentUser[conUserId],
          },
        );
      });

      Navigator.of(context!).pushNamed(ChatScreen.routeNames);
    }
  }
}
