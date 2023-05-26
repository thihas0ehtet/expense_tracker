import 'package:expense/config/constants.dart';
import 'package:expense/views/payments/view.dart';
import 'package:expense/views/settings/data_backup.dart';
import 'package:expense/views/views.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Menu extends StatelessWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List menus = [
      {
        "name": 'accounts'.tr,
        "icon": Icons.person,
        "action": () => Get.to(() => AccountsView()),
      },
      {
        "name": 'categories'.tr,
        "icon": Icons.widgets,
        "action": () => Get.to(() => CategoriesView()),
      },
      {
        "name": 'payments'.tr,
        "icon": Icons.payment,
        "action": () => Get.to(() => PaymentView()),
      },
      {
        "name": 'languages'.tr,
        "icon": Icons.language,
        "action": () => showLanguageBox(context),
        "trailing": Text(
          Get.locale.toString() == "en_US" ? '🇺🇸 English' : '🇲🇲 မြန်မာ',
          style: const TextStyle(color: Colors.grey),
        )
      },
      {
        "name": 'Dark Mode',
        "icon": CupertinoIcons.moon,
        "action": () {
          Get.changeTheme(
            Get.isDarkMode ? ThemeData.light() : ThemeData.dark(),
          );
        },
        "trailing": Switch(
          value: context.isDarkMode ? true : false,
          activeColor: ConstantUitls.primaryColor,
          onChanged: (bool value) {
            Get.changeTheme(
              Get.isDarkMode ? ThemeData.light() : ThemeData.dark(),
            );
          },
        )
      },
      {
        "name": 'Data Backup / Restore',
        "icon": Icons.settings_backup_restore,
        "action": () => Get.to(() => const DataBackup()),
      }
    ];

    return Card(
      elevation: ConstantUitls.elevation,
      margin: const EdgeInsets.symmetric(
        horizontal: 15,
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ConstantUitls.radius)),
      child: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(ConstantUitls.radius)),
        child: Column(
          children: [
            for (var menu in menus)
              ListTile(
                leading: Icon(
                  menu['icon'],
                  color: ConstantUitls.primaryColor,
                ),
                title: Text(
                  menu['name'],
                ),
                trailing: menu['trailing'] ??
                    const Icon(
                      Icons.chevron_right,
                      color: Colors.grey,
                    ),
                onTap: menu['action'],
              ),
          ],
        ),
      ),
    );
  }

  showLanguageBox(BuildContext context) {
    showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          int? selectedRadio = Get.locale.toString() == "en_US" ? 1 : 0;
          return AlertDialog(
            title: Text(
              'languages'.tr,
            ),
            content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Radio<int>(
                            value: 0,
                            groupValue: selectedRadio,
                            onChanged: (int? value) {
                              Get.updateLocale(const Locale('mm', 'Uni'));
                              Navigator.pop(context);
                            },
                          ),
                          const Text('🇲🇲 မြန်မာ')
                        ],
                      ),
                      Row(
                        children: [
                          Radio<int>(
                            value: 1,
                            groupValue: selectedRadio,
                            onChanged: (int? value) {
                              Get.updateLocale(const Locale('en', 'US'));
                              Navigator.pop(context);
                            },
                          ),
                          const Text('🇺🇸 English')
                        ],
                      )
                    ]);
              },
            ),
          );
        });
  }
}
