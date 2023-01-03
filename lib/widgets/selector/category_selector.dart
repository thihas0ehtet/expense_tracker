import 'package:expense/controllers/controllers.dart';
import 'package:expense/views/categories/form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategorySelector extends StatefulWidget {
  final Function selectAction;

  const CategorySelector({
    Key? key,
    required this.selectAction,
  }) : super(key: key);

  @override
  CategorySelectorState createState() => CategorySelectorState();
}

class CategorySelectorState extends State<CategorySelector> {
  final CategoryController controller = Get.put(CategoryController());

  showForm() => showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: const CategoryForm(),
          ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('categories'.tr),
        actions: [
          IconButton(
              onPressed: showForm,
              // onPressed: showBottomSheetUtil(context, const CategoryForm(),
              //     callBackAction: getData),
              icon: const Icon(Icons.add_circle))
        ],
      ),
      body: Obx(() => controller.categories.isEmpty
          ? const Center(
              child: Text("No data"),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView(
                    children: ListTile.divideTiles(
                      color: Colors.grey.shade600,
                      tiles: controller.categories.map(
                        (e) => ListTile(
                          leading: const Icon(Icons.category),
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
