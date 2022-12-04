import 'package:chatapp/constants/constants.dart';
import 'package:chatapp/constants/default_buttons.dart';
import 'package:chatapp/otp_screen/take_profile_image.dart';
import 'package:chatapp/presentation/style/app_string.dart';
import 'package:chatapp/presentation/style/app_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class OtpFormScreen extends StatefulWidget {
  final String? code;

  const OtpFormScreen({Key? key, this.code}) : super(key: key);
  @override
  _OtpFormScreenState createState() => _OtpFormScreenState();
}

class _OtpFormScreenState extends State<OtpFormScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final _codeController1 = TextEditingController();

  void nextPage(String val, FocusNode focus) {
    if (val.length == 1) {
      focus.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final argData = ModalRoute.of(context)!.settings.arguments as List<String?>;

    return Form(
      key: _formkey,
      child: Column(
        children: [
          otpinputform(size: size, controler: _codeController1),
          SizedBox(height: size.height * .27),
          DefaultButton(
            press: () async {
              if (_formkey.currentState!.validate()) {
                _formkey.currentState!.save();

                PhoneAuthCredential phoneAuthCredential =
                    PhoneAuthProvider.credential(
                  verificationId: argData[0]!,
                  smsCode: _codeController1.text,
                );

                Navigator.of(context).pushNamed(TakeImage.routeNames,
                    arguments: [phoneAuthCredential, argData[1]]);
                // Navigator.of(context).pushNamed(AddFriendScreen.routeName);
              }
            },
            text: AppStringConstants.contin,
            size: size,
            buttoncolors: AppColors.primaryColor,
            textcolors: Colors.white,
          )
        ],
      ),
    );
  }

  Widget otpinputform({required Size size, TextEditingController? controler}) {
    return TextFormField(
      // autofocus: true,
      controller: controler,
      // obscureText: true,
      decoration: inputdecoretion(size),

      style: TextStyle(fontSize: size.height * 0.03),

      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
    );
  }

  InputDecoration inputdecoretion(Size size) {
    return InputDecoration(
      labelText: AppStringConstants.code,
      contentPadding: EdgeInsets.only(
        top: size.height * 0.025,
        bottom: size.height * 0.025,
        left: size.height * 0.03,
      ),
      border: bordershape(size),
    );
  }

  OutlineInputBorder bordershape(Size size) {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(size.width * 0.3),
        borderSide: BorderSide(
          color: AppColors.textColor,
        ));
  }
}
