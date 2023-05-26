import 'package:sqflite/sqflite.dart';

abstract class Tables {
  static String account = "account";
  static String category = "category";
  static String payment = "payment";
  static String transaction = "transactionTable";
}

class DatabaseService {
  static const int _version = 2;
  static const String _database = "expenseTracker.db";

  static Future<Database> initDB() async {
    String path = "${await getDatabasesPath()}/$_database";
    return openDatabase(
      path,
      version: _version,
      onCreate: (db, version) async {
        await createTables(db);
      },
    );
  }

  static Future<void> createTables(Database database) async {
    String id = "id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL";
    String createdAt = "createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP";

    await database.execute("""
      CREATE TABLE ${Tables.account} (
        $id ,
        name TEXT,
        $createdAt
      )
    """);

    await database.execute("""
      CREATE TABLE ${Tables.category} (
        $id ,
        name TEXT,
        $createdAt
      )
    """);

    await database.execute("""
      CREATE TABLE ${Tables.payment} (
        $id ,
        name TEXT,
        $createdAt
      )
    """);

    await database.execute("""
      CREATE TABLE ${Tables.transaction} (
        $id ,
        type TEXT,
        accountId INTEGER,
        payment TEXT,
        category TEXT,
        amount REAL,
        image BLOB,
        date TEXT,
        note TEXT,
        $createdAt
      )
    """);
  }
}
