import 'package:chatapp/constants/constants.dart';
import 'package:chatapp/constants/default_buttons.dart';
import 'package:chatapp/constants/splash_screen_texts_images.dart';
import 'package:chatapp/sign_up_screen/sign_up_screen.dart';
import 'package:chatapp/splash_screen/logo.dart';
import 'package:chatapp/splash_screen/splash_spot.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  static const String routeNames = 'home';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      // appBar: AppBar(),
      body: Container(
        decoration: BoxDecoration(
          image: _currentPage == 0
              ? DecorationImage(
                  image: AssetImage('assets/images/Bg.png'),
                  fit: BoxFit.cover,
                )
              : null,
        ),
        width: double.infinity,
        height: double.infinity,
        // height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: size.height * 0.07),
              logo(size: size, currentPage: _currentPage),
              SizedBox(height: size.height * 0.1),
              logoAndText(size, splashData),
              SizedBox(height: size.height * 0.03),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  splashData.length,
                  (index) => SplashSpot(
                    index: index,
                    currentPage: _currentPage,
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.05),
              DefaultButton(
                size: size,
                textcolors: _currentPage == 0 ? textColor : Colors.white,
                press: () => Navigator.of(context).pushNamedAndRemoveUntil(
                    SignUpScreen.routeNames, (route) => false),
                buttoncolors: _currentPage == 0 ? Colors.white : primaryColor,
                text: _currentPage == 2 ? 'Finsh' : 'Next',
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget logoAndText(Size size, List<Map<String, String>> splashData) {
    return SizedBox(
      width: double.infinity,
      height: _currentPage == 0 ? size.height * 0.46 : size.height * 0.46,
      child: PageView.builder(
        onPageChanged: (val) => setState(
          () {
            _currentPage = val;
          },
        ),
        itemBuilder: (ctx, index) => ListView(
          children: [
            image(size, splashData[index]['image']!, _currentPage),
            SizedBox(height: size.height * 0.01),
            Padding(
              padding: EdgeInsets.all(size.height * 0.04),
              child: Text(
                splashData[index]['text']!,
                style: TextStyle(fontSize: size.height * 0.03),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        itemCount: 3,
      ),
    );
  }
}
