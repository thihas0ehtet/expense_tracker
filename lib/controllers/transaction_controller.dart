import 'package:expense/config/constants.dart';
import 'package:expense/models/models.dart';
import 'package:expense/services/database_service.dart';
import 'package:get/get.dart';

class TransactionController extends GetxController {
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
}
