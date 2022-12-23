import 'package:flutter/material.dart';

import '../../config/constants.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Widget? widget;
  final GestureTapCallback press;
  final Color color, textColor;
  final String? buttonSize;
  const CustomButton(
      {Key? key,
      this.text = "",
      this.widget,
      required this.press,
      this.color = ConstantUitls.primaryColor,
      this.textColor = Colors.white,
      this.buttonSize = "md"})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return Container(
      // margin: const EdgeInsets.symmetric(vertical: 10),
      // width: size.width < 640 ? size.width : size.width * 0.5,
      height: buttonSize == "sm" ? 40 : 50,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(ConstantUitls.radius),
      ),
      child: ClipRRect(
        child: ElevatedButton(
          style: TextButton.styleFrom(
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
          onPressed: press,
          child: widget ??
              Text(
                text,
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: buttonSize == "sm" ? 13 : 16,
                ),
              ),
        ),
      ),
    );
  }
}
