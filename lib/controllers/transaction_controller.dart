import 'package:expense/config/constants.dart';
import 'package:expense/models/models.dart';
import 'package:expense/services/database_service.dart';
import 'package:get/get.dart';

class TransactionController extends GetxController {
  List<TransactionModel> transactions = <TransactionModel>[].obs;
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
}
