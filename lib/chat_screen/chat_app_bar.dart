import 'package:chatapp/constants/constants.dart';
import 'package:flutter/material.dart';

class ChatAppBar extends StatelessWidget {
  const ChatAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(top: size.height * 0.02),
      color: appBarColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
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
              print('settings');
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
