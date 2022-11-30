import 'package:chatapp/presentation/style/app_assets.dart';
import 'package:flutter/material.dart';

Widget logo({Size? size, int? currentPage}) {
  return Column(
    children: [
      Container(
        child: currentPage == 0
            ? Image.asset(
                AppAssetsConstants.logo,
                width: size!.height * 0.3,
              )
            : Image.asset(
                AppAssetsConstants.logo2,
                width: size!.height * 0.3,
              ),
      ),
    ],
  );
}

Widget image(Size size, String splashData, int currentPage) {
  return Container(
    width: size.width * 0.8,
    child: Image.asset(
      splashData,
      height: currentPage == 0 ? size.height * 0.4 : size.height * 0.2,
    ),
  );
}
