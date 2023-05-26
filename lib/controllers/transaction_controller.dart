import 'dart:io';

import 'package:excel/excel.dart';
import 'package:expense/config/constants.dart';
import 'package:expense/controllers/account_controller.dart';
import 'package:expense/models/models.dart';
import 'package:expense/services/database_service.dart';
import 'package:expense/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class TransactionController extends GetxController {
  final AccountController accountController = Get.put(AccountController());
  List<TransactionModel> transactions = <TransactionModel>[].obs;
  RxString selectedAccountId = "".obs;

  String tableName = Tables.transaction;

  @override
  void onReady() {
    super.onReady();
    getData();
  }

  getData() async {
    final db = await DatabaseService.initDB();
    List<Map<String, dynamic>> list = await db.query(tableName);
    transactions.assignAll(
        list.map((data) => TransactionModel.fromJson(data)).toList());
  }

  getTotalAmount(String type) {
    double total = 0;
    for (var transaction in transactions) {
      if (transaction.type == type) {
        if (selectedAccountId.isNotEmpty) {
          if (transaction.accountId.toString() ==
              selectedAccountId.toString()) {
            total += transaction.amount;
          }
        } else {
          total += transaction.amount;
        }
      }
    }
    return total;
  }

  getAllAmount() {
    double totalIncome = getTotalAmount(ConstantUitls.income);
    double totalExpense = getTotalAmount(ConstantUitls.expense);
    if (totalIncome > totalExpense) {
      return totalIncome - totalExpense;
    }
    return totalExpense - totalIncome;
  }

  Future<void> handleAction(String method,
      {int? id, TransactionModel? transaction}) async {
    final db = await DatabaseService.initDB();

    switch (method) {
      case ConstantUitls.postMethod:
        await db.insert(tableName, transaction!.toJson());
        break;

      case ConstantUitls.putMethod:
        await db.update(tableName, transaction!.toJson(),
            where: "id = ?", whereArgs: [id]);
        break;

      case ConstantUitls.deleteMethod:
        await db.delete(tableName, where: "id=?", whereArgs: [id]);
        break;
    }

    getData();
  }

  onChangeAccount(value) {
    selectedAccountId.value = value;
    Get.back();
  }

  exportExcel() async {
    final excel = Excel.createExcel();
    final sheet = excel[excel.getDefaultSheet()!];

    List<String> dataList = [
      "No.",
      "Account",
      "Type",
      "Category",
      "Amount",
      "Payment",
      "Date",
      "Note",
    ];
    sheet.insertRowIterables(dataList, 0);

    for (var i = 0; i < transactions.length; i++) {
      TransactionModel transaction = transactions[i];

      List<String> list = [
        (i + 1).toString(),
        accountController.getAccountName(transaction.accountId),
        transaction.type,
        transaction.category,
        transaction.amount.toString(),
        transaction.payment ?? "",
        transaction.date,
        transaction.note ?? ""
      ];
      sheet.appendRow(list);
    }

    Directory? directory;

    try {
      if (Platform.isAndroid) {
        if (await Utils.requestPermission(Permission.storage) &&
            await Utils.requestPermission(Permission.accessMediaLocation) &&
            await Utils.requestPermission(Permission.manageExternalStorage)) {
          directory = await getExternalStorageDirectory();
          List<String> folders = directory!.path.split("/");
          String newPath = "";
          for (int i = 1; i < folders.length; i++) {
            String folder = folders[i];
            if (folder != "Android") {
              newPath += "/$folder";
            } else {
              break;
            }
          }
          newPath = "$newPath/ExpenseTracker/Transactions";
          directory = Directory(newPath);
        }
      }
      if (!await directory!.exists()) {
        await directory.create(recursive: true);
      }
      if (await directory.exists()) {
        String fileName =
            "${DateTime.now().toString().split(" ")[0]}-${DateTime.now().millisecondsSinceEpoch}";
        File("${directory.path}/$fileName.xlsx")
          ..createSync(recursive: true)
          ..writeAsBytesSync(excel.encode()!);

        Get.snackbar(
            "Success", "Transaction export success, view in ${directory.path}",
            backgroundColor: Colors.green,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
            duration: const Duration(seconds: 3));
      }
    } catch (e) {}
  }
}
