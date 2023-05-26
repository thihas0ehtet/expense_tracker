import 'package:expense/controllers/payment_controller.dart';
import 'package:expense/views/payments/form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentSelector extends StatefulWidget {
  final Function selectAction;

  const PaymentSelector({
    Key? key,
    required this.selectAction,
  }) : super(key: key);

  @override
  PaymentSelectorState createState() => PaymentSelectorState();
}

class PaymentSelectorState extends State<PaymentSelector> {
  final PaymentController controller = Get.put(PaymentController());

  showForm() => showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: const PaymentForm(),
          ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('payments'.tr),
        actions: [
          IconButton(onPressed: showForm, icon: const Icon(Icons.add_circle))
        ],
      ),
      body: Obx(() => controller.payments.isEmpty
          ? const Center(
              child: Text("No data"),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView(
                    children: ListTile.divideTiles(
                      color: Colors.grey.shade600,
                      tiles: controller.payments.map(
                        (e) => ListTile(
                          leading: const Icon(Icons.payment),
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
