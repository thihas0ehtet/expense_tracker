import 'package:expense/config/constants.dart';
import 'package:expense/controllers/controllers.dart';
import 'package:expense/models/models.dart';
import 'package:expense/utils/utils.dart';
import 'package:expense/views/categories/form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoriesView extends StatelessWidget {
  CategoriesView({Key? key}) : super(key: key);
  final CategoryController controller = Get.put(CategoryController());

  @override
  Widget build(BuildContext context) {
    showForm({CategoryModel? category}) => Utils.handleShowBottomSheet(
        context,
        CategoryForm(
          category: category,
        ));

    return Scaffold(
        appBar: AppBar(
          title: Text("categories".tr),
          actions: [
            IconButton(
                splashRadius: 20,
                onPressed: showForm,
                icon: const Icon(Icons.add_circle_outline)),
          ],
        ),
        body: Obx(() {
          if (controller.categories.isEmpty) {
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
                      DataColumn(
                          label: Expanded(
                              child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          'category'.tr,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
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
                    rows: controller.categories
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
                              //                 showForm(category: element),
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
                                                showForm(category: element);
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
