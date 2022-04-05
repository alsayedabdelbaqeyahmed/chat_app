import 'dart:io';
import 'package:chatapp/add_friends/add_friends_screen.dart';
import 'package:chatapp/constants/constants.dart';
import 'package:chatapp/constants/userDataModel.dart';
import 'package:chatapp/multiuserchats/multi_user_screens.dart';

import 'package:chatapp/otp_screen/otp_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpProvider with ChangeNotifier {
  FirebaseAuth _auth = FirebaseAuth.instance;
  String? username, usercountry, userdialCode, userphone;

  String? _verifactionID2;
  String? get verificationID => _verifactionID2;
  String? _chatUserName;
  String? get chatUserNmae => _chatUserName;
  static String? _userId;
  static String? get userId => _userId;

  Future<void> signUpWithPhone({
    required PhoneAuthCredential phonecredintial,
    required String? phoneNumber,
    BuildContext? context,
    File? image,
  }) async {
    try {
      final authcredintial = await _auth.signInWithCredential(phonecredintial);
      // add the user details to the database
      _userId = authcredintial.user!.uid;

      final ref = FirebaseStorage.instance
          .ref()
          .child('Profile_Image')
          .child(_userId! + '.jpg');
      await ref.putFile(image!).whenComplete(
        () async {
          final profileImageUrl = await ref.getDownloadURL();

          await FirebaseFirestore.instance
              .collection(conUserCollectios)
              .doc(phoneNumber)
              .set(
            {
              conuserName: username,
              conuserCountry: usercountry,
              conuserDialCode: userdialCode,
              conuserPhone: userphone,
              conUserId: authcredintial.user!.uid,
              conUserImageUrl: profileImageUrl.toString(),
            },
          ).whenComplete(
            () {
              _userId = authcredintial.user!.uid;
              Navigator.of(context!).pushNamed(MultiUserChats.routeNames);
            },
          );
        },
      );
    } catch (e) {
      print(e);
    }
  }

  Future<void> enterPhoneNumber({
    required String phoneNumber,
    BuildContext? context,
    String? name,
    String? country,
    String? dialCode,
  }) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (phoneauth) async {
          await signUpWithPhone(
            phonecredintial: phoneauth,
            context: context,
            phoneNumber: phoneNumber,
          );
        },
        verificationFailed: (FirebaseAuthException e) {
          if (e.code == 'invalid-phone-number') {
            print('The provided phone number is not valid.');
          }

          print(e.message);
          print('The provided phone number is not valid.');
        },
        codeSent: (verificationId, resendingToken) async {
          _verifactionID2 = verificationId;

          Navigator.of(context!).pushNamed(OtpScreen.routeNames,
              arguments: [verificationID, phoneNumber]);
          username = name;
          usercountry = country;
          userdialCode = dialCode;
          userphone = phoneNumber;
        },
        codeAutoRetrievalTimeout: (verificationId) async {},
      );
    } catch (e) {}
  }

  Future<void> signOut() async {
    try {
      var db = LocalDataBase.db;
      await db.deleteAllData().then(
        (value) async {
          final ref = FirebaseStorage.instance
              .ref()
              .child('Profile_Image')
              .child(_userId! + '.jpg');
          ref.delete();
          await _auth.signOut();
        },
      );
    } catch (e) {}
  }

  Future<void> deleteAccount() async {
    try {
      var db = LocalDataBase.db;
      await db.deleteAllData().then(
        (value) async {
          final ref = FirebaseStorage.instance
              .ref()
              .child('Profile_Image')
              .child(_userId! + '.jpg');
          ref.delete();
          final delete = _auth.currentUser;
          await delete!.delete();
        },
      );
    } catch (e) {}
  }

  Future<void> updateProfilePhoto({File? image, String? phoneNumber}) async {
    final currentUser = await FirebaseFirestore.instance
        .collection(conUserCollectios)
        .doc(phoneNumber)
        .get();
    final ref = FirebaseStorage.instance
        .ref()
        .child('Profile_Image')
        .child(currentUser[conUserId] + '.jpg');
    await ref.putFile(image!).whenComplete(
      () async {
        final profileImageUrl = await ref.getDownloadURL();

        await FirebaseFirestore.instance
            .collection(conUserCollectios)
            .doc(phoneNumber)
            .update(
          {
            conUserImageUrl: profileImageUrl.toString(),
          },
        );
      },
    );
  }
}
