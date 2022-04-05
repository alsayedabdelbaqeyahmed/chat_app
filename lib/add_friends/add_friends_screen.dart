import 'package:chatapp/chat_screen/chat_app_bar.dart';
import 'package:chatapp/sign_up_screen/sign_up_form.dart';
import 'package:flutter/material.dart';

class AddFriendScreen extends StatelessWidget {
  const AddFriendScreen({Key? key}) : super(key: key);
  static const routeName = 'AddFriendScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constrain) {
          return SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.only(
                      top: constrain.maxHeight * 0.05,
                      bottom: constrain.maxHeight * 0.01,
                    ),
                    child: Image.asset('assets/images/firends.png'),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.only(
                      start: constrain.maxWidth * 0.05,
                      end: constrain.maxWidth * .05,
                      top: constrain.maxHeight * 0.05,
                      bottom: constrain.maxHeight * 0.05,
                    ),
                    child: SignUpForm(
                      isFrirend: true,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
