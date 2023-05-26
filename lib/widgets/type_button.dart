import 'package:expense/config/constants.dart';
import 'package:flutter/material.dart';

class TypeButton extends StatelessWidget {
  final String title;
  final String transactionType;
  final String radiusPostion;
  final Function selectedAction;

  const TypeButton(
      {Key? key,
      required this.title,
      required this.transactionType,
      this.radiusPostion = "start",
      required this.selectedAction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => selectedAction(),
      child: Container(
        decoration: BoxDecoration(
            color: transactionType == title ? ConstantUitls.primaryColor : null,
            borderRadius: radiusPostion == "start"
                ? const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10))
                : radiusPostion == "end"
                    ? const BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10))
                    : null),
        child: Align(
            alignment: Alignment.center,
            child: Text(
              title,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: transactionType == title ? Colors.white : null),
            )),
      ),
    );
  }
}
