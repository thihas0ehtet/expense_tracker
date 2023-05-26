import 'dart:io';
import 'package:expense/config/constants.dart';
import 'package:expense/controllers/controllers.dart';
import 'package:expense/models/models.dart';
import 'package:expense/models/payment_model.dart';
import 'package:expense/utils/utils.dart';
import 'package:expense/widgets/form/input_select.dart';
import 'package:expense/widgets/selector/account_selector.dart';
import 'package:expense/widgets/selector/category_selector.dart';
import 'package:expense/widgets/selector/payment_selector.dart';
import 'package:expense/widgets/type_button.dart';
import 'package:expense/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
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
  TextEditingController payment = TextEditingController();
  TextEditingController amount = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController note = TextEditingController();
  AccountModel? selectedAccount;
  CategoryModel? selectedCategory;
  PaymentModel? selectedPayment;
  final TransactionController controller = Get.put(TransactionController());
  final AccountController accountController = Get.put(AccountController());
  String transactionType = "Expense";
  DateTime selectedDate = DateTime.now();
  var image;

  @override
  void initState() {
    super.initState();
    if (widget.transaction != null) {
      transactionType = widget.transaction!.type;
      account.text =
          accountController.getAccountName(widget.transaction?.accountId ?? 0);
      category.text = widget.transaction?.category.toString() ?? "";
      payment.text = widget.transaction?.payment.toString() ?? "";
      amount.text = widget.transaction?.amount.toString() ?? "";
      date.text = widget.transaction?.date ?? "";
      note.text = widget.transaction?.note ?? "";
      selectedDate =
          DateFormat('yyyy-MM-dd').parse(widget.transaction?.date ?? "");
      image = widget.transaction?.image;
    }
  }

  submitAction() async {
    if (account.text.isEmpty || amount.text.isEmpty || category.text.isEmpty) {
      Utils.showMessage("Fail", "Please fill data!", color: Colors.red);
    }

    if (widget.transaction == null) {
      TransactionModel data = TransactionModel(
          type: transactionType,
          accountId: selectedAccount?.id ?? 0,
          category: category.text,
          amount: double.parse(amount.text),
          payment: payment.text,
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
          payment: payment.text,
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

  handleSelectPayment(PaymentModel selectedItem) {
    selectedPayment = selectedItem;
    setState(() {});
    payment.text = selectedItem.name;
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
                          radiusPostion: 'end',
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
              label: "Account *",
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
              label: "Category *",
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
              label: "Amount *",
            ),
            InputSelect(
              label: "Payment",
              controller: payment,
              selectAction: () => PaymentSelector(
                selectAction: handleSelectPayment,
              ),
              showCancelButton: selectedPayment != null,
              cancelAction: () {
                selectedPayment = null;
                payment.text = "";
                setState(() {});
              },
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
            const SizedBox(
              width: double.infinity,
              child: Text(
                "Receipt image",
                style: TextStyle(
                  color: Color(0xff51515b),
                  fontSize: 14,
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            image != null
                ? Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    padding: const EdgeInsets.only(bottom: 5),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                          Radius.circular(ConstantUitls.radius)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(ConstantUitls.radius)),
                              child: SizedBox(
                                width: double.infinity,
                                height: 170,
                                child: Image.memory(
                                  image,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                                top: 0,
                                right: 0,
                                child: GestureDetector(
                                  onTap: () {
                                    image = null;
                                    setState(() {});
                                  },
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(
                                              ConstantUitls.radius),
                                          bottomLeft: Radius.circular(
                                              ConstantUitls.radius)),
                                    ),
                                    width: 30,
                                    height: 30,
                                    child: const SizedBox(
                                      width: 30,
                                      child: Icon(
                                        Icons.delete,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                )),
                          ],
                        ),
                      ],
                    ),
                  )
                : GestureDetector(
                    onTap: () async {
                      final imageSource = await Utils.selectImageSource();

                      XFile? pickedImage = await Utils.pickImage(imageSource);

                      image = File(pickedImage!.path).readAsBytesSync();
                      setState(() {});
                    },
                    child: Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: MediaQuery.of(context).size.width * 0.4,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(ConstantUitls.radius),
                          border: Border.all(
                            color: Colors.grey.shade300,
                            width: 1,
                          ),
                          color: Get.isDarkMode ? Colors.grey : Colors.white,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.upload,
                              size: 20,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text("Add receipt image",
                                style: TextStyle(
                                  color: Color(0xff51515b),
                                  fontSize: 13,
                                ))
                          ],
                        )),
                  ),
            const SizedBox(
              height: 15,
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
