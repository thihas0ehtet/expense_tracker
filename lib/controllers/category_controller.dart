import 'package:expense/config/constants.dart';
import 'package:expense/models/models.dart';
import 'package:expense/services/database_service.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  List<CategoryModel> categories = <CategoryModel>[].obs;
  String tableName = Tables.category;

  @override
  void onReady() {
    super.onReady();
    getData();
  }

  getData() async {
    final db = await DatabaseService.initDB();
    List<Map<String, dynamic>> list = await db.query(tableName);
    categories
        .assignAll(list.map((data) => CategoryModel.fromJson(data)).toList());
  }

  Future<void> handleAction(String method,
      {int? id, CategoryModel? category}) async {
    final db = await DatabaseService.initDB();

    switch (method) {
      case ConstantUitls.postMethod:
        await db.insert(tableName, category!.toJson());
        break;

      case ConstantUitls.putMethod:
        await db.update(tableName, category!.toJson(),
            where: "id = ?", whereArgs: [id]);
        break;

      case ConstantUitls.deleteMethod:
        await db.delete(tableName, where: "id=?", whereArgs: [id]);
        break;
    }

    getData();
  }
}
