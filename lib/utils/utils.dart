import 'package:expense/config/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

abstract class Utils {
  static String currencyFormat(String data) {
    if (data == "0") {
      return data;
    } else {
      var doubleFormat = double.parse(data);
      var formatter = NumberFormat(',###');
      String formatNumber = formatter.format(doubleFormat);
      return formatNumber;
    }
  }

  static String fullDateAndTime(String date) {
    DateTime dateTime = DateTime.parse(date);
    var formatter = DateFormat('dd-M-yyyy hh:mm a');
    String formatDate = formatter.format(dateTime);
    return formatDate;
  }

  static String dateOnlyFormat(String date) {
    DateTime dateTime = DateTime.parse(date);
    var formatter = DateFormat('dd/M/yyyy');
    String formatDate = formatter.format(dateTime);
    return formatDate;
  }

  static showMessage(String headerMsg, String bodyMsg,
      {Color color = Colors.green}) {
    Get.snackbar(
      headerMsg,
      bodyMsg,
      backgroundColor: color,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(milliseconds: 1500),
    );
  }

  static handleShowDatePicker(BuildContext context) {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime.now())
        .then((value) {
      return value;
    });
  }

  static handleDeleteConfirm(String label, Function confirmAction) {
    Get.defaultDialog(
      title: "Delete",
      radius: ConstantUitls.radius,
      buttonColor: ConstantUitls.primaryColor,
      confirmTextColor: Colors.white,
      content: Center(
        child: Text('Are you sure to delete $label?'),
      ),
      onCancel: () => {},
      onConfirm: () => {Get.back(), confirmAction()},
    );
  }

  static handleShowBottomSheet(context, Widget child) => showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: child,
          ));
}
