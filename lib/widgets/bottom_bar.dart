import 'package:expense/config/constants.dart';
import 'package:expense/views/views.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomBar extends StatefulWidget {
  final int selectedIndex;
  const BottomBar({
    Key? key,
    this.selectedIndex = 0,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _currentTabIndex = 0;
  String userRole = "";

  @override
  void initState() {
    super.initState();
    _currentTabIndex = widget.selectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      const HomeView(),
      TransactionsView(),
      // const ReportsView(),
      const SettingsView(),
    ];
    final bottomNavBarItems = <BottomNavigationBarItem>[
      BottomNavigationBarItem(
          icon: const Icon(CupertinoIcons.home), label: 'home'.tr),
      BottomNavigationBarItem(
          icon: const Icon(Icons.receipt_long), label: 'transactions'.tr),
      // BottomNavigationBarItem(
      //     icon: const Icon(CupertinoIcons.chart_bar_square),
      //     label: 'reports'.tr),
      BottomNavigationBarItem(
          icon: const Icon(Icons.settings), label: 'setting'.tr),
    ];

    assert(pages.length == bottomNavBarItems.length);
    final bottomNavBar = BottomNavigationBar(
      items: bottomNavBarItems,
      currentIndex: _currentTabIndex,
      selectedItemColor: ConstantUitls.primaryColor,
      type: BottomNavigationBarType.fixed,
      onTap: (int index) {
        setState(() {
          _currentTabIndex = index;
        });
      },
    );
    return Scaffold(
      body: pages[_currentTabIndex],
      bottomNavigationBar: bottomNavBar,
    );
  }
}
