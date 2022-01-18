import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:chatapp/constants/constants.dart';
import 'package:chatapp/constants/default_buttons.dart';
import 'package:chatapp/providers/sign_up_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class TakeImage extends StatefulWidget {
  const TakeImage({Key? key}) : super(key: key);
  static const routeNames = 'Take_Image';

  @override
  _TakeImageState createState() => _TakeImageState();
}

class _TakeImageState extends State<TakeImage> {
  File? _selectedImage;
  String? _sourceofImage;
  final picker = ImagePicker();
  bool isTaking = false;

  Future selectThesourceofImage(BuildContext context, Size size) {
    return AwesomeDialog(
      padding: EdgeInsets.all(10),
      context: context,
      dialogType: DialogType.QUESTION,
      body: Column(children: [
        Text(
          'Chose the sorce Image',
          style: TextStyle(color: Colors.black, fontSize: size.height * 0.02),
        ),
        SizedBox(height: size.height * 0.005),
        Text(
          'Camera or gallery',
          style: TextStyle(color: Colors.red, fontSize: size.height * 0.025),
        ),
      ]),
      btnOkText: 'camera',
      btnOkOnPress: () => setState(() {
        _sourceofImage = 'camera';
      }),
      btnCancelText: 'gallery',
      btnCancelOnPress: () => setState(() {
        _sourceofImage = 'gallery';
      }),
    ).show();
  }

  Future pickImage(BuildContext context) async {
    final pickedImage = await picker.pickImage(
      source: _sourceofImage == 'camera'.trim()
          ? ImageSource.camera
          : _sourceofImage == 'gallery'.trim()
              ? ImageSource.gallery
              : ImageSource.camera,
    );
    if (pickedImage == null) {
      return;
    }
    setState(() {
      _selectedImage = File(pickedImage.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final providerData = Provider.of<SignUpProvider>(context);
    final argData =
        ModalRoute.of(context)!.settings.arguments as PhoneAuthCredential?;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(height: size.height * 0.1),
          Image.asset(
            'assets/images/Logo2.png',
            width: size.height * 0.3,
          ),
          SizedBox(height: size.height * 0.02),
          Text(
            'Pick up the profile image',
            style: TextStyle(color: textColor, fontSize: size.height * 0.02),
          ),
          SizedBox(height: size.height * 0.02),
          Expanded(
            child: Stack(
              fit: StackFit.expand,
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.all(size.height * 0.05),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: primaryColor,
                    ),
                  ),
                  child: _selectedImage == null
                      ? Center(
                          child: Text(
                            'Your Image',
                            style: TextStyle(
                              fontSize: size.height * 0.05,
                              color: textColor,
                            ),
                          ),
                        )
                      : CircleAvatar(
                          backgroundImage: FileImage(
                            _selectedImage!,
                          ),
                        ),
                ),
                Positioned(
                  left: size.height * 0.4,
                  bottom: size.height * 0.16,
                  child: SizedBox(
                    child: TextButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          Color(0xFFF5F6F9),
                        ),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                            side: BorderSide(color: Colors.white),
                          ),
                        ),
                      ),
                      child: Icon(
                        Icons.camera_alt_outlined,
                        size: size.height * 0.05,
                      ),
                      onPressed: () async {
                        await selectThesourceofImage(context, size);
                        await pickImage(context);
                        setState(() {
                          isTaking = true;
                        });
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: size.height * 0.02),
          isTaking == false
              ? DefaultButton(
                  size: size,
                  press: () async {
                    await selectThesourceofImage(context, size);
                    await pickImage(context);
                    setState(() {
                      isTaking = true;
                    });
                  },
                  text: 'select the imgae',
                  textcolors: textColor,
                  buttoncolors: primaryColor,
                )
              : DefaultButton(
                  size: size,
                  press: () async {
                    await providerData.signUpWithPhone(
                      phonecredintial: argData!,
                      context: context,
                      image: _selectedImage!,
                    );
                  },
                  text: 'Finish',
                  textcolors: textColor,
                  buttoncolors: primaryColor,
                )
        ],
      ),
    );
  }
}
