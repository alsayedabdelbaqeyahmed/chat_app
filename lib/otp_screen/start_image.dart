import 'package:flutter/material.dart';

class StartImageWidget extends StatelessWidget {
  const StartImageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.08,
      width: size.height * 0.25,
      decoration: BoxDecoration(
        border: Border.all(
          color: Color(0xffFFC813),
          width: size.height * 0.008,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(50),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8, top: 8, bottom: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            image(
                size: size,
                assets: 'assets/images/Path 20.png',
                hight: size.height * .2),
            image(size: size, assets: 'assets/images/Path 20.png'),
            image(size: size, assets: 'assets/images/Path 20.png'),
            image(size: size, assets: 'assets/images/Path 20.png'),
          ],
        ),
      ),
    );
  }

  Widget image({Size? size, required String assets, double? hight}) {
    return Image.asset(
      assets,
      height: hight,
    );
  }
}
