import 'dart:io';

import 'package:expense/config/constants.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sqflite/sqflite.dart';

class DataBackup extends StatelessWidget {
  const DataBackup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Data backup / restore"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(ConstantUitls.margin),
        child: Column(
          children: [
            _settingMenu(context,
                icon: "assets/images/storage.png",
                label: "Data Backup", onTap: () {
              _backupDB();
              // _openFile();
            }),
            const SizedBox(
              height: ConstantUitls.margin,
            ),
            _settingMenu(context,
                icon: "assets/images/database_restore.png",
                label: "Restore Data", onTap: () {
              _restoreDB();
            }),
          ],
        ),
      ),
    );
  }

  _settingMenu(BuildContext context,
      {required String icon, required String label, Null Function()? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 130,
        padding: const EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 2,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(icon),
            Text(
              label,
              style: const TextStyle(fontSize: 18),
            )
          ],
        ),
      ),
    );
  }

  _backupDB() async {
    final dbFolder = await getDatabasesPath();
    File file = File("$dbFolder/expense.db");
    Directory? directory;

    try {
      if (Platform.isAndroid) {
        if (await _requestPermission(Permission.storage) &&
            await _requestPermission(Permission.accessMediaLocation) &&
            await _requestPermission(Permission.manageExternalStorage)) {
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
          newPath = "$newPath/ExpenseTracker/BackupFiles";
          directory = Directory(newPath);
        }
      }
      if (!await directory!.exists()) {
        await directory.create(recursive: true);
      }
      if (await directory.exists()) {
        String newPath =
            "${directory.path}/${DateTime.now().millisecondsSinceEpoch}pos.db";
        file.copySync(newPath);
        await FilePicker.platform.pickFiles(initialDirectory: directory.path);

        Get.snackbar("Success",
            "Data backup success view in storage/emulated/0/ExpenseTracker/BackupFiles",
            backgroundColor: Colors.green,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
            duration: const Duration(seconds: 3));
      }
    } catch (e) {}
  }

  _restoreDB() async {
    var databasePath = await getDatabasesPath();
    var dbPath = "$databasePath/expense.db";

    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result == null) {
      return;
    }
    File source = File(result.files.single.path!);

    await source.copy(dbPath);
    Get.snackbar("Success", "Data Restore success",
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3));
  }

  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      } else {
        return false;
      }
    }
  }
}
