import 'package:expense/config/constants.dart';
import 'package:expense/utils/utils.dart';
import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({
    Key? key,
    this.icon,
    required this.text,
    this.quantity,
    this.color,
    this.valueColor,
    required this.press,
  }) : super(key: key);

  final IconData? icon;
  final String text;
  final double? quantity;
  final Color? color;
  final Color? valueColor;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ConstantUitls.radius)),
      child: InkWell(
        onTap: press,
        borderRadius: BorderRadius.circular(ConstantUitls.radius),
        child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: color,
              borderRadius:
                  const BorderRadius.all(Radius.circular(ConstantUitls.radius)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(
                      text,
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Text(
                      Utils.currencyFormat(quantity.toString()),
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: valueColor ?? Colors.black),
                    ),
                  ],
                ),
              ],
            )),
      ),
    ));
  }
}
