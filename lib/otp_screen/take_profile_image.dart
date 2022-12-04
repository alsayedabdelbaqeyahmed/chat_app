import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:chatapp/constants/constants.dart';
import 'package:chatapp/constants/default_buttons.dart';
import 'package:chatapp/presentation/controller/providers/sign_up_provider.dart';
import 'package:chatapp/presentation/style/app_assets.dart';
import 'package:chatapp/presentation/style/app_string.dart';
import 'package:chatapp/presentation/style/app_theme.dart';

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
          AppStringConstants.choseImage,
          style: TextStyle(color: Colors.black, fontSize: size.height * 0.02),
        ),
        SizedBox(height: size.height * 0.005),
        Text(
          AppStringConstants.cameraOrGallery,
          style: TextStyle(color: Colors.red, fontSize: size.height * 0.025),
        ),
      ]),
      btnOkText: AppStringConstants.camera,
      btnOkOnPress: () => setState(() {
        _sourceofImage = AppStringConstants.camera;
      }),
      btnCancelText: AppStringConstants.gallery,
      btnCancelOnPress: () => setState(() {
        _sourceofImage = AppStringConstants.gallery;
      }),
    ).show();
  }

  Future pickImage(BuildContext context) async {
    final pickedImage = await picker.pickImage(
      source: _sourceofImage == AppStringConstants.camera.trim()
          ? ImageSource.camera
          : _sourceofImage == AppStringConstants.gallery.trim()
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
    final argData = ModalRoute.of(context)!.settings.arguments as List<dynamic>;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(height: size.height * 0.1),
          Image.asset(
            AppAssetsConstants.logo2,
            width: size.height * 0.3,
          ),
          SizedBox(height: size.height * 0.02),
          Text(
            AppStringConstants.pickImage,
            style: TextStyle(
                color: AppColors.textColor, fontSize: size.height * 0.02),
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
                      color: AppColors.primaryColor,
                    ),
                  ),
                  child: _selectedImage == null
                      ? Center(
                          child: Text(
                            AppStringConstants.yourImage,
                            style: TextStyle(
                              fontSize: size.height * 0.05,
                              color: AppColors.textColor,
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
                  text: AppStringConstants.selectImage,
                  textcolors: AppColors.textColor,
                  buttoncolors: AppColors.primaryColor,
                )
              : DefaultButton(
                  size: size,
                  press: () async {
                    await providerData.signUpWithPhone(
                      phonecredintial: argData[0]!,
                      context: context,
                      image: _selectedImage!,
                      phoneNumber: argData[1],
                    );
                  },
                  text: AppStringConstants.finish,
                  textcolors: AppColors.textColor,
                  buttoncolors: AppColors.primaryColor,
                )
        ],
      ),
    );
  }
}
