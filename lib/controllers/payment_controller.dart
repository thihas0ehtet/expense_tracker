import 'package:expense/config/constants.dart';
import 'package:expense/models/payment_model.dart';
import 'package:expense/services/database_service.dart';
import 'package:get/get.dart';

class PaymentController extends GetxController {
  List<PaymentModel> payments = <PaymentModel>[].obs;
  String tableName = Tables.payment;

  @override
  void onReady() {
    super.onReady();
    getData();
  }

  getData() async {
    final db = await DatabaseService.initDB();
    List<Map<String, dynamic>> list = await db.query(tableName);
    payments
        .assignAll(list.map((data) => PaymentModel.fromJson(data)).toList());
  }

  getAccountName(int id) {
    return payments.firstWhere((element) => element.id == id).name;
  }

  Future<void> handleAction(String method,
      {int? id, PaymentModel? payment}) async {
    final db = await DatabaseService.initDB();

    switch (method) {
      case ConstantUitls.postMethod:
        await db.insert(tableName, payment!.toJson());
        break;

      case ConstantUitls.putMethod:
        await db.update(tableName, payment!.toJson(),
            where: "id = ?", whereArgs: [id]);
        break;

      case ConstantUitls.deleteMethod:
        await db.delete(tableName, where: "id=?", whereArgs: [id]);
        break;
    }

    getData();
  }
}
