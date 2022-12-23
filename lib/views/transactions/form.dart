import 'package:expense/config/constants.dart';
import 'package:expense/controllers/controllers.dart';
import 'package:expense/models/models.dart';
import 'package:expense/utils/utils.dart';
import 'package:expense/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransactionForm extends StatefulWidget {
  final TransactionModel? transaction;

  const TransactionForm({Key? key, this.transaction}) : super(key: key);

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  TextEditingController type = TextEditingController();
  TextEditingController account = TextEditingController();
  TextEditingController category = TextEditingController();
  TextEditingController amount = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController note = TextEditingController();
  AccountModel? selectedAccount;
  CategoryModel? selectedCategory;
  final TransactionController controller = Get.put(TransactionController());

  @override
  void initState() {
    super.initState();
    if (widget.transaction != null) {
      type.text = widget.transaction?.type ?? "";
      account.text = widget.transaction?.accountId.toString() ?? "";
      category.text = widget.transaction?.categoryId.toString() ?? "";
      amount.text = widget.transaction?.amount.toString() ?? "";
      date.text = widget.transaction?.date ?? "";
      note.text = widget.transaction?.note ?? "";
    }
  }

  submitAction() async {
    if (account.text.isEmpty) {
      Utils.showMessage("Fail", "Please fill data!", color: Colors.red);
    }

    if (widget.transaction == null) {
      TransactionModel data = TransactionModel(
          type: type.text,
          accountId: selectedAccount?.id ?? 0,
          categoryId: selectedCategory?.id ?? 0,
          amount: double.parse(amount.text),
          date: date.text,
          note: note.text);
      await controller.handleAction(ConstantUitls.postMethod,
          transaction: data);
    } else {
      TransactionModel data = TransactionModel(
          id: widget.transaction?.id,
          type: type.text,
          accountId: selectedAccount?.id ?? 0,
          categoryId: selectedCategory?.id ?? 0,
          amount: double.parse(account.text),
          date: date.text,
          note: note.text);
      await controller.handleAction(ConstantUitls.putMethod,
          id: widget.transaction?.id, transaction: data);
    }

    Get.back(result: "success");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.transaction == null
            ? "New transaction"
            : "Edit transaction"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InputField(
              context,
              controller: type,
              label: "Type".tr,
            ),
            InputField(
              context,
              controller: account,
              label: "Account".tr,
            ),
            InputField(
              context,
              controller: category,
              label: "Category".tr,
            ),
            InputField(
              context,
              controller: amount,
              label: "Amount".tr,
            ),
            InputField(
              context,
              controller: date,
              label: "Date".tr,
            ),
            InputField(
              context,
              controller: note,
              label: "Note".tr,
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
