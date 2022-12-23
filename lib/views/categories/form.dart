import 'package:expense/config/constants.dart';
import 'package:expense/controllers/controllers.dart';
import 'package:expense/models/models.dart';
import 'package:expense/utils/utils.dart';
import 'package:expense/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryForm extends StatefulWidget {
  final CategoryModel? category;

  const CategoryForm({Key? key, this.category}) : super(key: key);

  @override
  State<CategoryForm> createState() => _CategoryFormState();
}

class _CategoryFormState extends State<CategoryForm> {
  TextEditingController name = TextEditingController();
  final CategoryController controller = Get.put(CategoryController());

  @override
  void initState() {
    super.initState();
    if (widget.category != null) {
      name.text = widget.category?.name ?? "";
    }
  }

  submitAction() async {
    if (name.text.isEmpty) {
      Utils.showMessage("Category", "Please fill data!", color: Colors.red);
    }

    if (widget.category == null) {
      CategoryModel data = CategoryModel(name: name.text);
      await controller.handleAction(ConstantUitls.postMethod, category: data);
    } else {
      CategoryModel data =
          CategoryModel(id: widget.category?.id, name: name.text);
      await controller.handleAction(ConstantUitls.putMethod,
          id: widget.category?.id, category: data);
    }

    Get.back(result: "success");
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(ConstantUitls.radius)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.category == null ? "New category" : "Edit category",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(
              height: 20,
            ),
            InputField(
              context,
              controller: name,
              label: "category".tr,
            ),
            SizedBox(
              width: double.infinity,
              child: CustomButton(
                press: submitAction,
                text: 'save'.tr,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
