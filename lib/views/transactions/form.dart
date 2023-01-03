import 'package:expense/config/constants.dart';
import 'package:expense/controllers/controllers.dart';
import 'package:expense/models/models.dart';
import 'package:expense/utils/utils.dart';
import 'package:expense/widgets/form/input_select.dart';
import 'package:expense/widgets/selector/account_selector.dart';
import 'package:expense/widgets/selector/category_selector.dart';
import 'package:expense/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final TransactionModel? transaction;

  const TransactionForm({Key? key, this.transaction}) : super(key: key);

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  TextEditingController account = TextEditingController();
  TextEditingController category = TextEditingController();
  TextEditingController amount = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController note = TextEditingController();
  AccountModel? selectedAccount;
  CategoryModel? selectedCategory;
  final TransactionController controller = Get.put(TransactionController());
  final AccountController accountController = Get.put(AccountController());
  String transactionType = "Expense";
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    if (widget.transaction != null) {
      transactionType = widget.transaction!.type;
      account.text =
          accountController.getAccountName(widget.transaction?.accountId ?? 0);
      category.text = widget.transaction?.category.toString() ?? "";
      amount.text = widget.transaction?.amount.toString() ?? "";
      date.text = widget.transaction?.date ?? "";
      note.text = widget.transaction?.note ?? "";
      selectedDate =
          DateFormat('yyyy-MM-dd').parse(widget.transaction?.date ?? "");
    }
  }

  submitAction() async {
    if (account.text.isEmpty) {
      Utils.showMessage("Fail", "Please fill data!", color: Colors.red);
    }

    if (widget.transaction == null) {
      TransactionModel data = TransactionModel(
          type: transactionType,
          accountId: selectedAccount?.id ?? 0,
          category: category.text,
          amount: double.parse(amount.text),
          date: DateFormat('yyyy-MM-dd').format(selectedDate),
          note: note.text);
      await controller.handleAction(ConstantUitls.postMethod,
          transaction: data);
    } else {
      TransactionModel data = TransactionModel(
          id: widget.transaction?.id,
          type: transactionType,
          accountId: selectedAccount != null
              ? selectedAccount?.id ?? 0
              : widget.transaction!.accountId,
          category: category.text,
          amount: double.parse(amount.text),
          date: DateFormat('yyyy-MM-dd').format(selectedDate),
          note: note.text);
      await controller.handleAction(ConstantUitls.putMethod,
          id: widget.transaction?.id, transaction: data);
    }

    Get.back(result: "success");
  }

  handleSelectAccount(AccountModel selectedItem) {
    selectedAccount = selectedItem;
    setState(() {});
    account.text = selectedItem.name;
    Navigator.of(context).pop();
  }

  handleSelectCategory(CategoryModel selectedItem) {
    selectedCategory = selectedItem;
    setState(() {});
    category.text = selectedItem.name;
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            widget.transaction == null ? "New transaction" : "Transaction"),
        actions: [
          if (widget.transaction != null)
            IconButton(
              onPressed: () =>
                  Utils.handleDeleteConfirm("transaction", () async {
                await controller.handleAction(ConstantUitls.deleteMethod,
                    id: widget.transaction?.id);
                Get.back(result: "success");
              }),
              splashRadius: 20,
              icon: const Icon(CupertinoIcons.trash),
            )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
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
                          title: "Expense",
                          transactionType: transactionType,
                          selectedAction: () {
                            transactionType = "Expense";
                            setState(() {});
                          })),
                  Expanded(
                      child: TypeButton(
                          title: "Income",
                          transactionType: transactionType,
                          selectedAction: () {
                            transactionType = "Income";
                            setState(() {});
                          })),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            InputSelect(
              label: "Account",
              controller: account,
              selectAction: () => AccountSelector(
                selectAction: handleSelectAccount,
              ),
              showCancelButton: selectedAccount != null,
              cancelAction: () {
                selectedAccount = null;
                account.text = "";
                setState(() {});
              },
            ),
            InputSelect(
              label: "Category",
              controller: category,
              selectAction: () => CategorySelector(
                selectAction: handleSelectCategory,
              ),
              showCancelButton: selectedCategory != null,
              cancelAction: () {
                selectedCategory = null;
                category.text = "";
                setState(() {});
              },
            ),
            InputField(
              context,
              controller: amount,
              inputType: TextInputType.number,
              label: "Amount".tr,
            ),
            InkWell(
              onTap: () {
                _showDatePicker(context);
              },
              child: InputField(
                context,
                enabled: false,
                label: "Date",
                leftIcon: const Icon(Icons.calendar_today_outlined),
                controller: TextEditingController(
                  text: DateFormat('yyyy-MM-dd').format(selectedDate),
                ),
              ),
            ),
            InputField(
              context,
              label: "Note",
              widget: TextField(
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
                maxLines: 3,
                controller: note,
              ),
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

  _showDatePicker(BuildContext context) {
    showDatePicker(
            context: context,
            initialDate: selectedDate,
            firstDate: DateTime(2020),
            lastDate: DateTime.now())
        .then((value) {
      if (value == null) {
        return;
      }

      setState(() {
        selectedDate = value;
      });
    });
  }
}

class TypeButton extends StatelessWidget {
  final String title;
  final String transactionType;
  final Function selectedAction;

  const TypeButton(
      {Key? key,
      required this.title,
      required this.transactionType,
      required this.selectedAction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => selectedAction(),
      child: Container(
        decoration: BoxDecoration(
            color: transactionType == title ? ConstantUitls.primaryColor : null,
            borderRadius: transactionType == "Expense"
                ? const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10))
                : const BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10))),
        child: Align(
            alignment: Alignment.center,
            child: Text(
              title,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: transactionType == title ? Colors.white : null),
            )),
      ),
    );
  }
}
