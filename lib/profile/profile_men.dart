import 'package:chatapp/constants/constants.dart';
import 'package:chatapp/presentation/style/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProfileMenue extends StatelessWidget {
  final String? icon;
  final String? name;
  final VoidCallback? press;

  const ProfileMenue({Key? key, this.icon, this.name, this.press})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      padding:
          EdgeInsets.only(left: size.height * 0.03, right: size.height * 0.01),
      // width: size.width * 0.8,
      height: size.width * 0.18,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        // border: Border.all(color: Colors.red),
        color: AppColors.primaryColor,
      ),
      child: Row(
        //  mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SvgPicture.asset(icon!,
              color: Colors.white, height: size.height * 0.035),
          SizedBox(width: size.height * 0.03),
          Expanded(
            child: Text(
              name!,
              style: TextStyle(fontSize: size.height * 0.03),
            ),
          ),
        ],
      ),
    );
  }
}
