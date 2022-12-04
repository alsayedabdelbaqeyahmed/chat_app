import 'package:awesome_dialog/awesome_dialog.dart';

import 'package:chatapp/constants/constants.dart';
import 'package:chatapp/multiuserchats/multi_user_screens.dart';
import 'package:chatapp/presentation/style/app_string.dart';

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
        .collection(AppConstansts.conUserCollectios)
        .doc(friendNumber)
        .get();
    final currentUser = await FirebaseFirestore.instance
        .collection(AppConstansts.conUserCollectios)
        .doc(userPhone)
        .get();

    final users = await FirebaseFirestore.instance
        .collection(AppConstansts.conUserCollectios)
        .get();
    final userList = users.docs.map((e) => e.data()).toList();

    final element = userList.firstWhere(
      (element) => element[AppConstansts.conuserPhone] == friendNumber,
      orElse: () => {},
    );

    if (element[AppConstansts.conuserPhone] == userPhone || element.isEmpty) {
      AwesomeDialog(
        padding: EdgeInsets.all(10),
        context: context!,
        dialogType: DialogType.ERROR,
        body: Column(children: [
          element[AppConstansts.conuserPhone] != userPhone
              ? Text(
                  AppStringConstants.user_not_found,
                  style: TextStyle(color: Colors.black, fontSize: 20),
                )
              : Text(
                  AppStringConstants.that_is_you,
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
          SizedBox(height: 20),
          element[AppConstansts.conuserPhone] != userPhone
              ? Text(
                  AppStringConstants.invite_friend,
                  style: TextStyle(color: Colors.red, fontSize: 15),
                )
              : Text(
                  AppStringConstants.stop_kidding,
                  style: TextStyle(color: Colors.red, fontSize: 15),
                ),
        ]),
        btnOkText: AppStringConstants.cancel,
        btnOkOnPress: () {},
      ).show();
    } else {
      //  String? chatId = friendNumber! + userPhone;
      _friendAuth
          .collection(AppConstansts.conUserCollectios)
          .doc(currentUser[AppConstansts.conuserPhone])
          .collection(AppConstansts.conFriendCollection)
          .doc(friendNumber)
          .set(
        {
          AppConstansts.conFriendUserName:
              friendUser[AppConstansts.conuserName],
          AppConstansts.conFriendPhone: friendUser[AppConstansts.conuserPhone],
          AppConstansts.conuserPhone: currentUser[AppConstansts.conuserPhone],
          AppConstansts.conuserName: currentUser[AppConstansts.conuserName],
          AppConstansts.conUserImageUrl:
              friendUser[AppConstansts.conUserImageUrl],
          AppConstansts.conFriendId: friendUser[AppConstansts.conUserId],
          // conChatId: chatId
        },
      ).then((value) async {
        final userDoc = FirebaseFirestore.instance
            .collection(AppConstansts.conUserCollectios)
            .doc(userPhone)
            .collection(AppConstansts.conFriendCollection)
            .doc();

        //  final data = userDoc.docs.map((e) => e.data()).toList();
        print(userDoc);

        // print(userDoc.docs.toString());
        // print(userDoc.docChanges);

        _friendAuth
            .collection(AppConstansts.conUserCollectios)
            .doc(friendUser[AppConstansts.conuserPhone])
            .collection(AppConstansts.conFriendCollection)
            .doc(currentUser[AppConstansts.conuserPhone])
            .set(
          {
            AppConstansts.conFriendUserName:
                currentUser[AppConstansts.conuserName],
            AppConstansts.conFriendPhone:
                currentUser[AppConstansts.conuserPhone],
            AppConstansts.conuserPhone: friendUser[AppConstansts.conuserPhone],
            AppConstansts.conuserName: friendUser[AppConstansts.conuserName],
            AppConstansts.conUserImageUrl:
                currentUser[AppConstansts.conUserImageUrl],
            AppConstansts.conFriendId: currentUser[AppConstansts.conUserId],
            // conChatId: chatId
          },
        );
      });

      Navigator.of(context!).pushReplacementNamed(MultiUserChats.routeNames);
    }
  }
}
