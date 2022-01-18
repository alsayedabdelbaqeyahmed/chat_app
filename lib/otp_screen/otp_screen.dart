import 'package:chatapp/constants/constants.dart';
import 'package:chatapp/otp_screen/start_image.dart';
import 'package:flutter/material.dart';

import 'otp_form.dart';

class OtpScreen extends StatelessWidget {
  static const String routeNames = 'OtpScreen';
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      //appBar: AppBar(),
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.05, vertical: size.width * 0.08),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: size.height * .1),
                Image.asset(
                  'assets/images/Path 18.png',
                  height: size.height * 0.08,
                ),
                SizedBox(height: size.height * .02),
                StartImageWidget(),
                SizedBox(height: size.height * .05),
                Text(
                  'We sendet to your phone message \nto confirm your phone number.',
                  style: TextStyle(
                      color: textColor, fontSize: size.height * 0.028),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: size.height * .04),
                OtpFormScreen(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
