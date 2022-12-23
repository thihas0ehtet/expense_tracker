import 'package:expense/config/constants.dart';
import 'package:expense/controllers/controllers.dart';
import 'package:expense/models/models.dart';
import 'package:expense/utils/utils.dart';
import 'package:expense/views/accounts/form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountsView extends StatelessWidget {
  AccountsView({Key? key}) : super(key: key);
  final AccountController controller = Get.put(AccountController());

  @override
  Widget build(BuildContext context) {
    showForm({AccountModel? account}) => Utils.handleShowBottomSheet(
        context,
        AccountForm(
          account: account,
        ));

    return Scaffold(
        appBar: AppBar(
          title: Text("accounts".tr),
          actions: [
            IconButton(
                splashRadius: 20,
                onPressed: showForm,
                icon: const Icon(Icons.add_circle_outline))
          ],
        ),
        body: Obx(() {
          if (controller.accounts.isEmpty) {
            return const Center(
              child: Text("No data"),
            );
          }
          return ListView(
            padding: const EdgeInsets.only(bottom: 20),
            children: [
              const SizedBox(
                height: 20,
              ),
              Card(
                margin: const EdgeInsets.symmetric(
                  horizontal: ConstantUitls.margin,
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: DataTable(
                    horizontalMargin: 0,
                    columnSpacing: ConstantUitls.margin,
                    border: TableBorder.all(
                      width: 0.001,
                    ),
                    columns: [
                      const DataColumn(
                          label: Expanded(
                              child: Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text(
                          'No.',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ))),
                      DataColumn(
                          label: Expanded(
                              child: Text(
                        'account'.tr,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ))),
                      const DataColumn(
                          label: Expanded(
                              child: Text(
                        '',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ))),
                    ],
                    rows: controller.accounts
                        .map(
                          (element) => DataRow(
                            cells: [
                              DataCell(Align(
                                alignment: Alignment.center,
                                child: Text(
                                    (controller.accounts.indexOf(element) + 1)
                                        .toString()),
                              )),
                              DataCell(Text(
                                element.name,
                              )),
                              DataCell(Container(
                                margin: const EdgeInsets.only(right: 10),
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      IconButton(
                                          onPressed: () =>
                                              showForm(account: element),
                                          splashRadius: 20,
                                          icon: const Icon(
                                            Icons.edit,
                                            size: 18,
                                            color: ConstantUitls.primaryColor,
                                          )),
                                      IconButton(
                                          onPressed: () =>
                                              Utils.handleDeleteConfirm(
                                                  element.name,
                                                  () => controller.handleAction(
                                                      ConstantUitls
                                                          .deleteMethod,
                                                      id: element.id ?? 0)),
                                          splashRadius: 20,
                                          icon: const Icon(
                                            CupertinoIcons.trash,
                                            size: 18,
                                            color: Colors.red,
                                          ))
                                    ],
                                  ),
                                ),
                              )),
                            ],
                          ),
                        )
                        .toList(),
                  ),
                ),
              )
            ],
          );
        }));
  }
}
