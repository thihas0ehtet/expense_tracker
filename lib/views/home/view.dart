import 'package:expense/controllers/controllers.dart';
import 'package:expense/views/home/bar_chart.dart';
import 'package:expense/views/home/cash_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final AccountController accountController = Get.put(AccountController());
  final TransactionController transactionController =
      Get.put(TransactionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Expense Tracker",
        ),
        actions: [
          IconButton(
              splashRadius: 20,
              onPressed: () => showAccounts(context),
              icon: const Icon(Icons.person))
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(15),
        children: [
          Obx(
            () => Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Text(
                transactionController.selectedAccountId.value.isEmpty
                    ? "All Accounts"
                    : accountController.getAccountName(int.parse(
                        transactionController.selectedAccountId.value)),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const CashInfo(),
          HomeBarChart(),
        ],
      ),
    );
  }

  showAccounts(BuildContext context) {
    showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'accounts'.tr,
            ),
            content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Obx(() => Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Radio(
                                value: "",
                                groupValue: transactionController
                                    .selectedAccountId.value,
                                onChanged: (value) => transactionController
                                    .onChangeAccount(value),
                              ),
                              InkWell(
                                onTap: () =>
                                    transactionController.onChangeAccount(""),
                                child: const Text('All Accounts'),
                              ),
                            ],
                          ),
                          for (var account in accountController.accounts)
                            Row(
                              children: [
                                Radio(
                                  value: account.id!.toString(),
                                  groupValue: transactionController
                                      .selectedAccountId.value,
                                  onChanged: (value) => transactionController
                                      .onChangeAccount(account.id!.toString()),
                                ),
                                InkWell(
                                  onTap: () => transactionController
                                      .onChangeAccount(account.id!.toString()),
                                  child: Text(account.name),
                                ),
                              ],
                            ),
                        ]));
              },
            ),
          );
        });
  }
}
