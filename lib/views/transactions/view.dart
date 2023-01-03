import 'package:expense/controllers/controllers.dart';
import 'package:expense/models/models.dart';
import 'package:expense/views/transactions/form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransactionsView extends StatelessWidget {
  TransactionsView({Key? key}) : super(key: key);
  final TransactionController controller = Get.put(TransactionController());
  final AccountController accountController = Get.put(AccountController());

  @override
  Widget build(BuildContext context) {
    showForm({TransactionModel? transaction}) async {
      await Get.to(() => TransactionForm(transaction: transaction));
      // if (result != null) {
      //   controller.handleGetData(productsRoute, isPrivate: false);
      // }
    }

    return Scaffold(
        appBar: AppBar(
          title: Text("transactions".tr),
          actions: [
            IconButton(
                splashRadius: 20,
                onPressed: showForm,
                icon: const Icon(Icons.add_circle_outline)),
            IconButton(
                splashRadius: 20,
                onPressed: () {},
                icon: const Icon(CupertinoIcons.slider_horizontal_3)),
            IconButton(
                splashRadius: 20,
                onPressed: () {},
                icon: const Icon(Icons.download))
          ],
        ),
        body: Obx(() {
          if (controller.transactions.isEmpty) {
            return const Center(
              child: Text("No data"),
            );
          }

          return ListView(
            children: ListTile.divideTiles(
              color: Colors.grey.shade600,
              tiles: controller.transactions.map(
                (e) => ListTile(
                  leading: const Icon(Icons.money),
                  title: Text(e.category),
                  subtitle: Text(
                      "${accountController.getAccountName(e.accountId)} ${e.date}"),
                  trailing: Text(
                    e.amount.toString(),
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: e.type == "Expense" ? Colors.red : Colors.green),
                  ),
                  onTap: () => showForm(transaction: e),
                ),
              ),
            ).toList(),
          );
        }));
  }
}
