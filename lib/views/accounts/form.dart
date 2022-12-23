import 'package:expense/config/constants.dart';
import 'package:expense/controllers/controllers.dart';
import 'package:expense/models/models.dart';
import 'package:expense/utils/utils.dart';
import 'package:expense/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountForm extends StatefulWidget {
  final AccountModel? account;

  const AccountForm({Key? key, this.account}) : super(key: key);

  @override
  State<AccountForm> createState() => _AccountFormState();
}

class _AccountFormState extends State<AccountForm> {
  TextEditingController name = TextEditingController();
  final AccountController controller = Get.put(AccountController());

  @override
  void initState() {
    super.initState();
    if (widget.account != null) {
      name.text = widget.account?.name ?? "";
    }
  }

  submitAction() async {
    if (name.text.isEmpty) {
      Utils.showMessage("Account", "Please fill data!", color: Colors.red);
    }

    if (widget.account == null) {
      AccountModel data = AccountModel(name: name.text);
      await controller.handleAction(ConstantUitls.postMethod, account: data);
    } else {
      AccountModel data = AccountModel(id: widget.account?.id, name: name.text);
      await controller.handleAction(ConstantUitls.putMethod,
          id: widget.account?.id, account: data);
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
              widget.account == null ? "New account" : "Edit account",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(
              height: 20,
            ),
            InputField(
              context,
              controller: name,
              label: "Account name",
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
