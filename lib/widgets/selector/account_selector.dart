import 'package:expense/controllers/controllers.dart';
import 'package:expense/views/accounts/form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountSelector extends StatefulWidget {
  final Function selectAction;

  const AccountSelector({
    Key? key,
    required this.selectAction,
  }) : super(key: key);

  @override
  AccountSelectorState createState() => AccountSelectorState();
}

class AccountSelectorState extends State<AccountSelector> {
  final AccountController controller = Get.put(AccountController());

  showForm() => showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: const AccountForm(),
          ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('accounts'.tr),
        actions: [
          IconButton(onPressed: showForm, icon: const Icon(Icons.add_circle))
        ],
      ),
      body: Obx(() => controller.accounts.isEmpty
          ? const Center(
              child: Text("No data"),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView(
                    children: ListTile.divideTiles(
                      color: Colors.grey.shade600,
                      tiles: controller.accounts.map(
                        (e) => ListTile(
                          leading: const Icon(Icons.person),
                          title: Text(e.name),
                          onTap: () {
                            widget.selectAction(e);
                          },
                        ),
                      ),
                    ).toList(),
                  ),
                ),
              ],
            )),
    );
  }
}
