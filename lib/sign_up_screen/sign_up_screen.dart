import 'package:chatapp/constants/constants.dart';
import 'package:chatapp/presentation/style/app_string.dart';

import 'package:chatapp/sign_up_screen/sign_up_form.dart';
import 'package:chatapp/splash_screen/logo.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  static const String routeNames = 'sign-up-screen';
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
          padding: EdgeInsets.only(
              left: size.height * 0.02, right: size.height * 0.02),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: size.height * 0.1),
                  logo(size: size),
                  SizedBox(height: size.height * 0.09),
                  Text(
                    AppStringConstants.register_number,
                    style: TextStyle(
                        color: textColor,
                        fontSize: size.height * 0.025,
                        height: size.height * 0.002),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: size.height * 0.05),
                  SignUpForm(isFrirend: false),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
