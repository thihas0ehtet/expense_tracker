import 'package:expense/config/constants.dart';
import 'package:expense/models/models.dart';
import 'package:expense/services/database_service.dart';
import 'package:get/get.dart';

class AccountController extends GetxController {
  List<AccountModel> accounts = <AccountModel>[].obs;
  String tableName = Tables.account;

  @override
  void onReady() {
    super.onReady();
    getData();
  }

  getData() async {
    final db = await DatabaseService.initDB();
    List<Map<String, dynamic>> list = await db.query(tableName);
    accounts
        .assignAll(list.map((data) => AccountModel.fromJson(data)).toList());
  }

  Future<void> handleAction(String method,
      {int? id, AccountModel? account}) async {
    final db = await DatabaseService.initDB();

    switch (method) {
      case ConstantUitls.postMethod:
        await db.insert(tableName, account!.toJson());
        break;

      case ConstantUitls.putMethod:
        await db.update(tableName, account!.toJson(),
            where: "id = ?", whereArgs: [id]);
        break;

      case ConstantUitls.deleteMethod:
        await db.delete(tableName, where: "id=?", whereArgs: [id]);
        break;
    }

    getData();
  }
}
