import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:chatapp/constants/constants.dart';
import 'package:chatapp/constants/userDataModel.dart';
import 'package:chatapp/providers/sign_up_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfilePic extends StatefulWidget {
  final String? userPhone;
  const ProfilePic({
    Key? key,
    this.userPhone,
  }) : super(key: key);

  @override
  _ProfilePicState createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> {
  // var userData = LocalDataBase.db;
  // UserDataModel? localUser;
  // Future<UserDataModel> localUserData() async {
  //   // var db = LocalDataBase.db;

  //   await userData.getUserData().then((value) {
  //     print(value);
  //     localUser = value;
  //     return localUser;
  //   });
  //   print(localUser!.userPhone2);
  //   return localUser!;
  // }

  @override
  Widget build(BuildContext context) {
    final providerData = Provider.of<SignUpProvider>(context, listen: false);

    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.height * 0.15,
      height: size.height * 0.15,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        // overflow: Overflow.visible,
        children: [
          SizedBox(
            child: FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection(conUserCollectios)
                  .doc(widget.userPhone)
                  .get(),
              builder: (ctx, data) {
                // print(data);
                final userData = data.hasData
                    ? (data.data as DocumentSnapshot).data()
                        as Map<String, dynamic>
                    : {};

                return data.connectionState == ConnectionState.waiting ||
                        !data.hasData
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : data.data == null
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : _selectedImage == null
                            ? CircleAvatar(
                                backgroundImage: NetworkImage(
                                  userData[conUserImageUrl],
                                ),
                              )
                            : CircleAvatar(
                                backgroundImage: FileImage(
                                  _selectedImage!,
                                ),
                              );
              },
            ),
          ),
          Positioned(
            right: -size.height * 0.015,
            bottom: 0,
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
                  // await localUserData();
                  // print(localUser!.userPhone2);
                  await providerData.updateProfilePhoto(
                    image: _selectedImage,
                    phoneNumber: widget.userPhone,
                  );
                  setState(() {});
                },
              ),
            ),
          )
        ],
      ),
    );
  }

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
}
