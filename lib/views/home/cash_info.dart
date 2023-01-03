import 'package:expense/config/constants.dart';
import 'package:expense/controllers/controllers.dart';
import 'package:expense/widgets/info_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CashInfo extends StatefulWidget {
  const CashInfo({Key? key}) : super(key: key);

  @override
  CashInfoState createState() => CashInfoState();
}

class CashInfoState extends State<CashInfo> {
  final TransactionController controller = Get.put(TransactionController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
          children: [
            Row(
              children: [
                InfoCard(
                    text: "Income",
                    quantity: controller.getTotalAmount(ConstantUitls.income),
                    valueColor: Colors.green,
                    press: () {}),
                InfoCard(
                    text: "Expense",
                    quantity: controller.getTotalAmount(ConstantUitls.expense),
                    valueColor: Colors.red,
                    press: () {}),
              ],
            ),
            Row(
              children: [
                InfoCard(
                    text: "Total",
                    quantity: controller.getAllAmount(),
                    valueColor:
                        controller.getTotalAmount(ConstantUitls.income) >
                                controller.getTotalAmount(ConstantUitls.expense)
                            ? Colors.green
                            : Colors.red,
                    press: () {}),
              ],
            ),
          ],
        ));
  }
}
