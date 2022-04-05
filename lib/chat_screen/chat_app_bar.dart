import 'package:chatapp/constants/constants.dart';
import 'package:chatapp/multiuserchats/multi_user_screens.dart';
import 'package:chatapp/profile/profile.dart';
import 'package:flutter/material.dart';

class ChatAppBar extends StatelessWidget {
  final String? userphone;
  const ChatAppBar({Key? key, this.userphone}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(top: size.height * 0.02),
      color: appBarColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            padding: EdgeInsetsDirectional.only(top: size.height * 0.03),
            onPressed: () => Navigator.of(context)
                .pushReplacementNamed(MultiUserChats.routeNames),
            icon: Icon(
              Icons.arrow_back,
            ),
          ),
          // SizedBox(width: size.width * 0.0),
          Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: size.height * 0.05,
                  bottom: size.height * 0.015,
                  left: size.height * 0.02,
                ),
                child: Image.asset(
                  'assets/images/chat.png',
                  height: size.height * 0.065,
                  width: size.height * 0.1,
                ),
              ),
              positinedElement(
                posleft: size.height * 0.033,
                posbottom: size.height * 0.023,
                chwidth: size.height * 0.08,
                chihight: size.height * 0.067,
                childType: 0,
              ),
              positinedElement(
                posleft: size.height * 0.1,
                posbottom: size.height * 0.063,
                chwidth: size.height * 0.006,
                chihight: size.height * 0.006,
                childType: 1,
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              print(userphone);
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => ProfileScreen(
                    userPhone: userphone,
                  ),
                ),
              );
            },
            child: Padding(
              padding: EdgeInsets.only(
                right: size.height * 0.03,
                top: size.height * 0.05,
                bottom: size.height * 0.02,
              ),
              child: Image.asset(
                'assets/images/Group 41.png',
                width: size.height * 0.05,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget positinedElement(
      {double? posleft,
      double? posbottom,
      double? chwidth,
      double? chihight,
      double? childType}) {
    return Positioned(
      left: posleft,
      bottom: posbottom,
      child: SizedBox(
        child: childType == 0
            ? Image.asset(
                'assets/images/Un.png',
                width: chwidth,
                height: chihight,
              )
            : Container(
                width: chwidth,
                height: chihight,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
      ),
    );
  }
}
