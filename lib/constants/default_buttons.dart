import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  final Size? size;

  final Color? textcolors;
  final Color? buttoncolors;
  final Function? press;
  final String? text;
  const DefaultButton({
    Key? key,
    this.size,
    this.text,
    this.buttoncolors,
    this.textcolors,
    this.press,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: size!.height * 0.02),
      child: TextButton(
        onPressed: press as void Function()?,
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(0),
          padding: MaterialStateProperty.all(EdgeInsets.zero),
        ),
        child: Container(
          padding: EdgeInsets.zero,
          width: size!.width * 0.92,
          height: size!.height * 0.08,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: buttoncolors,
          ),
          alignment: Alignment.center,
          child: Text(
            text!,
            style: TextStyle(color: textcolors, fontSize: size!.height * 0.04),
          ),
        ),
      ),
    );
  }
}
