import 'dart:io';

import 'package:chatapp/constants/constants.dart';
import 'package:chatapp/constants/userDataModel.dart';
import 'package:chatapp/presentation/controller/providers/chat_screen_provider.dart';
import 'package:chatapp/presentation/style/app_assets.dart';
import 'package:chatapp/presentation/style/app_string.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SendMessegesForm extends StatefulWidget {
  final String? chatUserId, userPhone, friendPhone;

  const SendMessegesForm({
    Key? key,
    this.chatUserId,
    required this.userPhone,
    required this.friendPhone,
  }) : super(key: key);
  @override
  _SendMessegesFormState createState() => _SendMessegesFormState();
}

class _SendMessegesFormState extends State<SendMessegesForm> {
  String? _eneteredMessege;
  bool show = false;

  final _controller = TextEditingController();
  FocusNode _focus = FocusNode();
  // UserDataModel? localUserPhone;

  // Future<UserDataModel> userData() async {
  //   var db = LocalDataBase.db;

  //   await db.getUserData().then((value) {
  //     print(value);
  //     localUserPhone = value;
  //     return localUserPhone;
  //   });
  //   return localUserPhone!;
  // }

  @override
  void initState() {
    //  userData();
    _focus.addListener(() {
      if (_focus.hasFocus) {
        setState(() {
          show = false;
        });
      }
    });

    super.initState();
  }

  final GlobalKey<FormState> _key = GlobalKey();

  void _sendMesseges() async {
    final user = FirebaseAuth.instance.currentUser!;
    final userName = await FirebaseFirestore.instance
        .collection(AppConstansts.conUserCollectios)
        .doc(widget.userPhone)
        .get();
    if (_key.currentState!.validate()) {
      _key.currentState!.save();
      await Provider.of<ChatScreenProvider>(context, listen: false).addMesseges(
        context: context,
        messeges: _eneteredMessege,
        userId: user.uid,
        userName: userName[AppConstansts.conuserName],
        chatUserId: widget.chatUserId,
        userPhone: widget.userPhone,
        freindPhone: widget.friendPhone,
      );
      FocusScope.of(context).unfocus();
      _controller.clear();
      setState(() {
        _eneteredMessege = '';
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _focus.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Form(
          key: _key,
          child: Padding(
            padding: EdgeInsets.only(
              left: size.height * 0.015,
              right: size.height * 0.015,
              top: size.height * 0.005,
            ),
            child: TextFormField(
              keyboardType: TextInputType.multiline,
              minLines: 1,
              maxLines: 3,
              focusNode: _focus,

              // maxLines: 1,
              decoration: inputDecoration(size),
              controller: _controller,
              onSaved: (val) {
                setState(() {
                  _eneteredMessege = val!.trim();
                });
              },
              validator: (val) {
                if (val!.trim() == null) {
                  return AppStringConstants.enterMessege;
                }
                if (val.trim().isEmpty) {
                  return AppStringConstants.enterMessege;
                }
                if (val.isEmpty) {
                  return AppStringConstants.enterMessege;
                }
                return null;
              },
            ),
          ),
        ),
        show
            ? SizedBox(
                height: size.height * 0.4,
                width: double.infinity,
                child: emojiPicker(),
              )
            : SizedBox.shrink()
      ],
    );
  }

  InputDecoration inputDecoration(Size size) {
    return InputDecoration(
      fillColor: Color(0xffEFEFEF),
      filled: true,
      suffixIcon: WillPopScope(
        onWillPop: () {
          if (show) {
            setState(() {
              show = false;
            });
          } else {
            Navigator.pop(context);
          }
          return Future.value(false);
        },
        child: Container(
          width: size.height * 0.155,
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  _focus.unfocus();
                  _focus.canRequestFocus = false;

                  setState(() {
                    show = !show;
                  });
                },
                child: Image.asset(
                  AppAssetsConstants.smileFace,
                  width: size.height * 0.04,
                ),
              ),
              SizedBox(width: size.height * 0.02),
              GestureDetector(
                onTap: _sendMesseges,
                child: Container(
                  margin: EdgeInsets.only(right: size.height * 0.012),
                  padding: EdgeInsets.only(
                    top: size.height * 0.015,
                    bottom: size.height * 0.015,
                    right: size.height * 0.019,
                    left: size.height * 0.019,
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xffEFD97E),
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                  ),
                  child: Image.asset(
                    AppAssetsConstants.sendEmail,
                    //height: size.height * 0.02,
                    width: size.height * 0.035,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      contentPadding: EdgeInsets.only(
        top: size.height * 0.03,
        bottom: size.height * 0.03,
        left: size.height * 0.03,
      ),
      hintText: AppStringConstants.typeHere,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Color(0xffC3C3C3),
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: Color(0xffC3C3C3),
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
    );
  }

  Widget emojiPicker() {
    return EmojiPicker(
      onEmojiSelected: (category, emoji) {
        _controller
          ..text += emoji.emoji
          ..selection = TextSelection.fromPosition(
              TextPosition(offset: _controller.text.length));
      },
      onBackspacePressed: () {
        _controller
          ..text = _controller.text.characters.skipLast(1).toString()
          ..selection = TextSelection.fromPosition(
              TextPosition(offset: _controller.text.length));
      },
      config: Config(
        columns: 7,
        emojiSizeMax: 30 * (Platform.isIOS ? 1.30 : 1.0),
        verticalSpacing: 0,
        horizontalSpacing: 0,
        initCategory: Category.RECENT,
        bgColor: const Color(0xFFF2F2F2),
        indicatorColor: Colors.blue,
        iconColor: Colors.grey,
        iconColorSelected: Colors.blue,
        showRecentsTab: true,
        recentsLimit: 28,
        noRecents: Text(AppStringConstants.noRecentImage),
        tabIndicatorAnimDuration: kTabScrollDuration,
        categoryIcons: const CategoryIcons(),
        buttonMode: ButtonMode.MATERIAL,
      ),
    );
  }
}
