import 'package:chatapp/constants/constants.dart';
import 'package:chatapp/constants/default_buttons.dart';
import 'package:chatapp/providers/sign_up_provider.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  CountryCode? countryType;
  String? name, phone;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final providerData = Provider.of<SignUpProvider>(context);
    return Form(
      key: _formkey,
      child: Column(
        children: [
          userInputForm(size: size, context: context, hintText: 'userName'),
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
                    countryType?.name == null ? 'مصر' : countryType!.name!,
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
          userInputForm(size: size, context: context, hintText: 'Phone Number'),
          SizedBox(height: size.height * 0.05),
          SizedBox(height: size.height * 0.08),
          DefaultButton(
            buttoncolors: primaryColor,
            text: 'Done',
            textcolors: Colors.white,
            size: size,
            press: () async {
              if (_formkey.currentState!.validate()) {
                _formkey.currentState!.save();

                await providerData.enterPhoneNumber(
                  phoneNumber: countryType?.dialCode != null
                      ? countryType!.dialCode! + phone!
                      : '+20',
                  context: context,
                  name: name,
                  country: countryType?.name == null ? 'مصر' : countryType!.name,
                  dialCode: countryType?.dialCode == null
                      ? '+20'
                      : countryType!.dialCode,
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
          return 'please enter a valid value';
        }
        if (hintText == 'Phone Number'.trim() &&
            val.contains(RegExp(r"^[a-zA-Z]+@[a-zA-Z]+\.[a-zA-Z]+"))) {
          return 'please enter a valid phone number';
        }

        return null;
      },
      onSaved: (val) {
        if (hintText == 'Phone Number'.trim()) {
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