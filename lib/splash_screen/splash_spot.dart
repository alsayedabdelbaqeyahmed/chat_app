import 'package:chatapp/constants/constants.dart';
import 'package:flutter/material.dart';

class SplashSpot extends StatelessWidget {
  const SplashSpot({Key? key, this.currentPage, this.index}) : super(key: key);
  final int? currentPage, index;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: currentPage == index ? size.height * 0.045 : size.height * 0.03,
      height: currentPage == index ? size.height * 0.025 : size.height * 0.03,
      margin: EdgeInsets.only(
        right: size.width * 0.04,
      ),
      decoration: BoxDecoration(
        color: currentPage == 0 && currentPage == index
            ? Colors.white
            : currentPage == index
                ? primaryColor
                : Colors.transparent,
        border:
            Border.all(color: currentPage == 0 ? Colors.white : primaryColor),
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}
