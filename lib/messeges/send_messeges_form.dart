import 'dart:io';

import 'package:chatapp/constants/constants.dart';
import 'package:chatapp/providers/chat_screen_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SendMessegesForm extends StatefulWidget {
  final String? chatUserId;

  const SendMessegesForm({Key? key, this.chatUserId}) : super(key: key);
  @override
  _SendMessegesFormState createState() => _SendMessegesFormState();
}

class _SendMessegesFormState extends State<SendMessegesForm> {
  String? _eneteredMessege;
  bool show = false;

  final _controller = TextEditingController();
  FocusNode _focus = FocusNode();

  @override
  void initState() {
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
        .collection(conUserCollectios)
        .doc(user.uid)
        .get();
    if (_key.currentState!.validate()) {
      _key.currentState!.save();
      await Provider.of<ChatScreenProvider>(context, listen: false).addMesseges(
          _eneteredMessege, user.uid, userName[conuserName], widget.chatUserId);
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
                  return 'please enter the messege';
                }
                if (val.trim().isEmpty) {
                  return 'please enter the messege';
                }
                if (val.isEmpty) {
                  return 'please enter the messege';
                }
                return null;
              },
            ),
          ),
        ),
        show
            ? SingleChildScrollView(
                child: emojiPicker(),
                scrollDirection: Axis.horizontal,
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
                  'assets/images/smiling-emoticon-square-face.png',
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
                    'assets/images/sent-mail.png',
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
      hintText: 'Type Here',
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
        // Do something when emoji is tapped
      },
      onBackspacePressed: () {
        // Backspace-Button tapped logic
        // Remove this line to also remove the button in the UI
      },
      config: Config(
        columns: 4,
        emojiSizeMax: 32 * (Platform.isIOS ? 1.30 : 1.0),
        verticalSpacing: 0,
        horizontalSpacing: 0,
        initCategory: Category.RECENT,
        bgColor: Color(0xFFF2F2F2),
        indicatorColor: Colors.blue,
        iconColor: Colors.grey,
        iconColorSelected: Colors.blue,
        progressIndicatorColor: Colors.blue,
        showRecentsTab: true,
        recentsLimit: 28,
        noRecentsText: "No Recents",
        noRecentsStyle: const TextStyle(fontSize: 20, color: Colors.black26),
        tabIndicatorAnimDuration: kTabScrollDuration,
        categoryIcons: const CategoryIcons(),
        buttonMode: ButtonMode.MATERIAL,
      ),
    );
  }
}
