import 'package:expense/config/constants.dart';
import 'package:expense/controllers/payment_controller.dart';
import 'package:expense/models/payment_model.dart';
import 'package:expense/utils/utils.dart';
import 'package:expense/views/payments/form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentView extends StatelessWidget {
  PaymentView({Key? key}) : super(key: key);
  final PaymentController controller = Get.put(PaymentController());

  @override
  Widget build(BuildContext context) {
    showForm({PaymentModel? payment}) => Utils.handleShowBottomSheet(
        context,
        PaymentForm(
          payment: payment,
        ));

    return Scaffold(
        appBar: AppBar(
          title: Text("payments".tr),
          actions: [
            IconButton(
                splashRadius: 20,
                onPressed: showForm,
                icon: const Icon(Icons.add_circle_outline))
          ],
        ),
        body: Obx(() {
          if (controller.payments.isEmpty) {
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
                    columns: const [
                      DataColumn(
                          label: Expanded(
                              child: Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text(
                          'Payment',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ))),
                      DataColumn(
                          label: Expanded(
                              child: Text(
                        '',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ))),
                    ],
                    rows: controller.payments
                        .map(
                          (element) => DataRow(
                            cells: [
                              DataCell(Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Text(element.name),
                              )),

                              // DataCell(Container(
                              //   margin: const EdgeInsets.only(right: 10),
                              //   child: Align(
                              //     alignment: Alignment.centerRight,
                              //     child: Row(
                              //       mainAxisAlignment: MainAxisAlignment.end,
                              //       children: [
                              //         IconButton(
                              //             onPressed: () =>
                              //                 showForm(payment: element),
                              //             splashRadius: 20,
                              //             icon: const Icon(
                              //               Icons.edit,
                              //               size: 18,
                              //               color: ConstantUitls.primaryColor,
                              //             )),
                              //         IconButton(
                              //             onPressed: () =>
                              //                 Utils.handleDeleteConfirm(
                              //                     element.name,
                              //                     () => controller.handleAction(
                              //                         ConstantUitls
                              //                             .deleteMethod,
                              //                         id: element.id ?? 0)),
                              //             splashRadius: 20,
                              //             icon: const Icon(
                              //               CupertinoIcons.trash,
                              //               size: 18,
                              //               color: Colors.red,
                              //             ))
                              //       ],
                              //     ),
                              //   ),
                              // )),
                              DataCell(Container(
                                margin: const EdgeInsets.only(right: 10),
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      SizedBox(
                                        width: 30,
                                        child: PopupMenuButton(
                                            padding: const EdgeInsets.all(0),
                                            splashRadius: 20,
                                            onSelected: (value) {
                                              if (value == 1) {
                                                showForm(payment: element);
                                              } else {
                                                Utils.handleDeleteConfirm(
                                                    element.name,
                                                    () =>
                                                        controller.handleAction(
                                                            ConstantUitls
                                                                .deleteMethod,
                                                            id: element.id ??
                                                                0));
                                              }
                                            },
                                            icon: Icon(
                                              Icons.more_vert,
                                              color: Colors.grey.shade600,
                                            ),
                                            itemBuilder: (context) => [
                                                  PopupMenuItem(
                                                    value: 1,
                                                    child: Row(
                                                      children: const [
                                                        Icon(
                                                          Icons.edit,
                                                          size: 20,
                                                          color: ConstantUitls
                                                              .primaryColor,
                                                        ),
                                                        SizedBox(
                                                          width: 8,
                                                        ),
                                                        Text(
                                                          "Edit",
                                                          style: TextStyle(
                                                              fontSize: 15),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  PopupMenuItem(
                                                    value: 2,
                                                    child: Row(
                                                      children: const [
                                                        Icon(
                                                          CupertinoIcons.trash,
                                                          size: 20,
                                                          color: Colors.red,
                                                        ),
                                                        SizedBox(
                                                          width: 8,
                                                        ),
                                                        Text(
                                                          "Delete",
                                                          style: TextStyle(
                                                              fontSize: 15),
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                ]),
                                      ),
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
