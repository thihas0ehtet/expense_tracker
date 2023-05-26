import 'package:expense/widgets/form/custom_button.dart';
import 'package:expense/widgets/type_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransactionFilter extends StatefulWidget {
  const TransactionFilter({
    Key? key,
  }) : super(key: key);

  @override
  TransactionFilterState createState() => TransactionFilterState();
}

class TransactionFilterState extends State<TransactionFilter> {
  String transactionType = "All";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filter'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(onPressed: () => Get.back(), icon: const Icon(Icons.close))
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Transaction type"),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: context.width > 300 ? 300 : (context.width - 20),
              height: 50,
              decoration: BoxDecoration(
                  border: Border.all(width: 0.5),
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              // padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Row(
                children: [
                  Expanded(
                      child: TypeButton(
                          title: "All",
                          transactionType: transactionType,
                          selectedAction: () {
                            transactionType = "All";
                            setState(() {});
                          })),
                  Expanded(
                      child: TypeButton(
                          title: "Expense",
                          transactionType: transactionType,
                          radiusPostion: '',
                          selectedAction: () {
                            transactionType = "Expense";
                            setState(() {});
                          })),
                  Expanded(
                      child: TypeButton(
                          title: "Income",
                          radiusPostion: 'end',
                          transactionType: transactionType,
                          selectedAction: () {
                            transactionType = "Income";
                            setState(() {});
                          })),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text("Select date"),
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    child: CustomButton(
                      color: Colors.red,
                      press: () {},
                      text: 'Clear'.tr,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: SizedBox(
                    child: CustomButton(
                      press: () {},
                      text: 'Search'.tr,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
