import 'package:chatapp/presentation/style/app_assets.dart';
import 'package:chatapp/presentation/style/app_string.dart';
import 'package:chatapp/profile/profile_men.dart';
import 'package:chatapp/profile/profile_pic.dart';
import 'package:chatapp/presentation/controller/providers/sign_up_provider.dart';
import 'package:chatapp/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  static const String routeNames = 'profile';
  final String? userPhone;

  const ProfileScreen({Key? key, this.userPhone}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            left: size.height * 0.03,
            right: size.height * 0.03,
            top: size.height * 0.05,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                ProfilePic(
                  userPhone: userPhone,
                ),
                SizedBox(height: size.height * 0.1),
                // ProfileMenue(
                //     icon: 'assets/images/User Icon.svg',
                //     name: 'My Account',
                //     press: () {}),
                // SizedBox(height: size.height * 0.2),
                InkWell(
                  onTap: () async {
                    Provider.of<SignUpProvider>(context, listen: false)
                        .signOut()
                        .then(
                          (value) => Navigator.of(context)
                              .pushReplacementNamed(SplashScreen.routeNames),
                        );
                  },
                  child: ProfileMenue(
                    icon: AppAssetsConstants.logoOut,
                    name: AppStringConstants.logOut,
                    press: () async {
                      Provider.of<SignUpProvider>(context, listen: false)
                          .signOut()
                          .then(
                            (value) => Navigator.of(context)
                                .pushReplacementNamed(SplashScreen.routeNames),
                          );
                    },
                  ),
                ),
                SizedBox(height: size.height * 0.05),
                InkWell(
                  onTap: () async {
                    Provider.of<SignUpProvider>(context, listen: false)
                        .deleteAccount()
                        .then(
                          (value) => Navigator.of(context)
                              .pushReplacementNamed(SplashScreen.routeNames),
                        );
                  },
                  child: ProfileMenue(
                    icon: AppAssetsConstants.logoOut,
                    name: AppStringConstants.delete,
                    press: () async {
                      Provider.of<SignUpProvider>(context, listen: false)
                          .deleteAccount()
                          .then(
                            (value) => Navigator.of(context)
                                .pushReplacementNamed(SplashScreen.routeNames),
                          );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
