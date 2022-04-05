import 'package:awesome_dialog/awesome_dialog.dart';

import 'package:chatapp/constants/constants.dart';
import 'package:chatapp/multiuserchats/multi_user_screens.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

class AddFriendProvider with ChangeNotifier {
  final _friendAuth = FirebaseFirestore.instance;

  Future<void> addFriends({
    //  required String? friendName,
    required String? friendNumber,
    required userPhone,
    // required userName,
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
        btnOkOnPress: () {},
      ).show();
    } else {
    //  String? chatId = friendNumber! + userPhone;
      _friendAuth
          .collection(conUserCollectios)
          .doc(currentUser[conuserPhone])
          .collection(conFriendCollection)
          .doc(friendNumber)
          .set(
        {
          conFriendUserName: friendUser[conuserName],
          conFriendPhone: friendUser[conuserPhone],
          conuserPhone: currentUser[conuserPhone],
          conuserName: currentUser[conuserName],
          conUserImageUrl: friendUser[conUserImageUrl],
          conFriendId: friendUser[conUserId],
         // conChatId: chatId
        },
      ).then((value) async {
        final userDoc = FirebaseFirestore.instance
            .collection(conUserCollectios)
            .doc(userPhone)
            .collection(conFriendCollection)
            .doc();

        //  final data = userDoc.docs.map((e) => e.data()).toList();
        print(userDoc);

        // print(userDoc.docs.toString());
        // print(userDoc.docChanges);

        _friendAuth
            .collection(conUserCollectios)
            .doc(friendUser[conuserPhone])
            .collection(conFriendCollection)
            .doc(currentUser[conuserPhone])
            .set(
          {
            conFriendUserName: currentUser[conuserName],
            conFriendPhone: currentUser[conuserPhone],
            conuserPhone: friendUser[conuserPhone],
            conuserName: friendUser[conuserName],
            conUserImageUrl: currentUser[conUserImageUrl],
            conFriendId: currentUser[conUserId],
           // conChatId: chatId
          },
        );
      });

      Navigator.of(context!).pushReplacementNamed(MultiUserChats.routeNames);
    }
  }
}
