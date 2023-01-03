import 'package:expense/config/constants.dart';
import 'package:expense/controllers/payment_controller.dart';
import 'package:expense/models/payment_model.dart';
import 'package:expense/utils/utils.dart';
import 'package:expense/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentForm extends StatefulWidget {
  final PaymentModel? payment;

  const PaymentForm({Key? key, this.payment}) : super(key: key);

  @override
  State<PaymentForm> createState() => _PaymentFormState();
}

class _PaymentFormState extends State<PaymentForm> {
  TextEditingController name = TextEditingController();
  final PaymentController controller = Get.put(PaymentController());

  @override
  void initState() {
    super.initState();
    if (widget.payment != null) {
      name.text = widget.payment?.name ?? "";
    }
  }

  submitAction() async {
    if (name.text.isEmpty) {
      Utils.showMessage("Payment", "Please fill data!", color: Colors.red);
    }

    if (widget.payment == null) {
      PaymentModel data = PaymentModel(name: name.text);
      await controller.handleAction(ConstantUitls.postMethod, payment: data);
    } else {
      PaymentModel data = PaymentModel(id: widget.payment?.id, name: name.text);
      await controller.handleAction(ConstantUitls.putMethod,
          id: widget.payment?.id, payment: data);
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
              widget.payment == null ? "New payment" : "Edit payment",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(
              height: 20,
            ),
            InputField(
              context,
              controller: name,
              label: "Paymentss name",
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
