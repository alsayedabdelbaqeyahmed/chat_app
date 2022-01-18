import 'package:chatapp/constants/constants.dart';
import 'package:chatapp/messeges/userImage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MessegeContainer extends StatelessWidget {
  final String? messgeg;
  final bool? isMe;
  final String? userName;
  final String? date;
  final bool? isUser;

  const MessegeContainer(
      {Key? key,
      this.messgeg,
      this.isMe,
      this.userName,
      this.date,
      this.isUser})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return FutureBuilder(
      future: FirebaseFirestore.instance
          .collection(conUserCollectios)
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get(),
      builder: (ctx, data) {
        if (data.connectionState == ConnectionState.waiting) {
          return SizedBox.shrink();
        }

        return Row(
          mainAxisAlignment:
              isMe! ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            isMe! ? dates() : SizedBox.shrink(),
            !isMe!
                ? userImage(
                    size, (data.data as dynamic)[conUserImageUrl], isMe!)
                : SizedBox.shrink(),
            Container(
              padding: EdgeInsets.all(size.height * 0.02),
              margin: EdgeInsets.only(
                left: size.height * 0.01,
                right: size.height * 0.01,
                bottom: size.height * 0.005,
                top: size.height * 0.005,
              ),
              width: size.height * 0.3,
              decoration: BoxDecoration(
                color: isMe! ? Color(0xffFFFFFF) : Color(0xffECF6FA),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                border: Border.all(
                  color: textColor,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    messgeg!,
                    style: TextStyle(
                      color: Color(0xff656565),
                      fontWeight: FontWeight.bold,
                      fontSize: size.height * 0.02,
                    ),
                  ),
                ],
              ),
            ),
            !isMe! ? dates() : SizedBox.shrink(),
            isMe!
                ? userImage(
                    size, (data.data as dynamic)[conUserImageUrl], isMe!)
                : SizedBox.shrink(),
          ],
        );
      },
    );
  }

  Text dates() {
    return Text(
      date!,
      style: TextStyle(
        color: isMe! ? Color(0xffFFC7F9) : textColor,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
