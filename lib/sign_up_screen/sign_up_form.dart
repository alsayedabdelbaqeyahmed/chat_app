import 'package:chatapp/constants/constants.dart';
import 'package:chatapp/constants/default_buttons.dart';
import 'package:chatapp/constants/userDataModel.dart';
import 'package:chatapp/presentation/controller/providers/add_friend_provider.dart';

import 'package:chatapp/presentation/controller/providers/sign_up_provider.dart';
import 'package:chatapp/presentation/style/app_string.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpForm extends StatefulWidget {
  final bool? isFrirend;
  static String? friendPhone;

  const SignUpForm({Key? key, required this.isFrirend}) : super(key: key);
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  CountryCode? countryType;
  String? name, phone;

  var userData = LocalDataBase.db;
  UserDataModel? localUser;
  String? localUserPhone;
  String? localUserName;

  Future<UserDataModel> localUserData() async {
    // var db = LocalDataBase.db;

    await userData.getUserData().then((value) {
      // print(value);
      localUser = value;
      return localUser;
    });
    return localUser!;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // final providerData = Provider.of<SignUpProvider>(context, listen: false);
    return Form(
      key: _formkey,
      child: Column(
        children: [
          widget.isFrirend!
              ? SizedBox.shrink()
              : userInputForm(
                  size: size,
                  context: context,
                  hintText: AppStringConstants.userName),
          SizedBox(height: size.height * 0.05),
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(
              top: size.height * 0.009,
              bottom: size.height * 0.009,
            ),
            decoration: BoxDecoration(
              border: Border.all(color: textColor),
              borderRadius: BorderRadius.all(
                Radius.circular(50),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(left: size.height * 0.01),
              child: Row(
                children: [
                  countryPicker(),
                  Text(
                    countryType?.name == null
                        ? AppStringConstants.egypt
                        : countryType!.name!,
                    style: TextStyle(
                      color: textColor,
                      fontSize: size.height * 0.04,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: size.height * 0.05),
          userInputForm(
              size: size,
              context: context,
              hintText: AppStringConstants.phoneNumber),
          SizedBox(height: size.height * 0.05),
          SizedBox(height: size.height * 0.08),
          DefaultButton(
            buttoncolors: primaryColor,
            text: widget.isFrirend!
                ? AppStringConstants.addNewFriend
                : AppStringConstants.done,
            textcolors: Colors.white,
            size: size,
            press: () async {
              final providerData =
                  Provider.of<SignUpProvider>(context, listen: false);
              final friendProvider =
                  Provider.of<AddFriendProvider>(context, listen: false);
              if (_formkey.currentState!.validate()) {
                _formkey.currentState!.save();
                if (widget.isFrirend != true)
                  userData.insertData(
                    UserDataModel(
                      userPhone2: countryType?.dialCode != null
                          ? countryType!.dialCode! + phone!
                          : '+20',
                      username: name,
                      friendPhone: '+20',
                    ),
                  );

                await localUserData();
                widget.isFrirend! != true
                    ? await providerData.enterPhoneNumber(
                        phoneNumber: countryType?.dialCode != null
                            ? countryType!.dialCode! + phone!
                            : '+20',
                        context: context,
                        name: name,
                        country: countryType?.name == null
                            ? AppStringConstants.egypt
                            : countryType!.name,
                        dialCode: countryType?.dialCode == null
                            ? '+20'
                            : countryType!.dialCode,
                      )
                    : await friendProvider
                        .addFriends(
                        context: context,
                        //friendName: name,
                        userPhone: localUser!.userPhone2,
                        friendNumber: countryType?.dialCode != null
                            ? countryType!.dialCode! + phone!
                            : '+20',
                        // userName: localUser!.username,
                      )
                        .then(
                        (value) {
                          userData.updateData(
                            UserDataModel(
                              userPhone2: localUser!.userPhone2,
                              username: localUser!.username,
                              friendPhone: countryType?.dialCode != null
                                  ? countryType!.dialCode! + phone!
                                  : '+20',
                              id: localUser!.id,
                            ),
                          );
                        },
                      );
                // print('${countryType.dialCode + phone}');
                // print(countryType.name);
              }
            },
          ),
        ],
      ),
    );
  }

  Widget countryPicker() {
    return CountryCodePicker(
      onChanged: (CountryCode country) => setState(() {
        countryType = country;
        // print(country);
        // print(countryType);
      }),
      initialSelection:
          countryType?.dialCode == null ? '+20' : countryType?.dialCode,
      onInit: (CountryCode? countryName) {
        countryType = countryName;
        // print(countryName);
        // print(countryType);
        // print(countryType.name);
      },
      showCountryOnly: false,
      showOnlyCountryWhenClosed: false,
      alignLeft: false,
    );
  }

  TextFormField userInputForm(
      {required Size size, BuildContext? context, String? hintText}) {
    return TextFormField(
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(
          top: size.height * 0.03,
          bottom: size.height * 0.03,
          left: size.height * 0.03,
        ),
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(50),
          ),
          borderSide: BorderSide(color: textColor),
        ),
      ),
      onEditingComplete: () => FocusScope.of(context!).unfocus(),
      validator: (val) {
        if (val!.isEmpty) {
          return AppStringConstants.validValue;
        }
        if (hintText == AppStringConstants.phoneNumber.trim() &&
            val.contains(RegExp(AppStringConstants.validNumberCondition))) {
          return AppStringConstants.validNumber;
        }

        return null;
      },
      onSaved: (val) {
        if (hintText == AppStringConstants.phoneNumber.trim()) {
          setState(() {
            phone = val;
          });
        } else {
          name = val;
        }
      },
    );
  }
}
