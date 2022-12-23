import 'package:expense/config/constants.dart';
import 'package:expense/views/settings/menu.dart';
import 'package:flutter/material.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.only(top: ConstantUitls.margin),
          child: Column(
            children: const [
              SizedBox(
                height: 30,
              ),
              SizedBox(
                height: 80.0,
                width: 80.0,
                child: CircleAvatar(
                  backgroundImage: AssetImage(
                    "assets/images/logo.png",
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                ConstantUitls.appName,
                style: TextStyle(
                    fontSize: 20,
                    color: ConstantUitls.primaryColor,
                    letterSpacing: 1,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                ConstantUitls.version,
                style: TextStyle(fontSize: 15, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 30,
              ),
              Menu(),
              SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ),
    );
  }
}
