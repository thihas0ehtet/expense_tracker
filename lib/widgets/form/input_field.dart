import 'package:expense/config/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget InputField(
  BuildContext context, {
  String? label,
  TextEditingController? controller,
  bool enabled = true,
  Icon? leftIcon,
  TextInputType? inputType,
  Widget? widget,
  FocusNode? focusNode,
  bool? isPassword = false,
  bool? showPassword,
  GestureTapCallback? handleShowPassword,
  GestureTapCallback? onEditingComplete,
  bool disableMargin = false,
}) {
  Size size = MediaQuery.of(context).size;
  return Container(
    margin: EdgeInsets.only(bottom: disableMargin ? 0 : ConstantUitls.margin),
    width: size.width < 640 ? size.width : size.width * 0.5,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: double.infinity,
          child: Text(
            label.toString(),
            style: const TextStyle(
              color: Color(0xff51515b),
              fontSize: 14,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(ConstantUitls.radius),
            border: Border.all(
              color: Colors.grey.shade300,
              width: 1,
            ),
            color: Get.isDarkMode ? Colors.grey : Colors.white,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(left: 10),
                  child: widget ??
                      TextField(
                        style: const TextStyle(height: 1),
                        keyboardType: inputType,
                        enabled: enabled,
                        controller: controller,
                        focusNode: focusNode,
                        onEditingComplete: onEditingComplete,
                        obscureText: isPassword! ? !showPassword! : false,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          suffixIcon: isPassword
                              ? IconButton(
                                  icon: const Icon(Icons.remove_red_eye),
                                  splashRadius: 20,
                                  color: showPassword!
                                      ? Colors.black
                                      : Colors.grey,
                                  onPressed: handleShowPassword,
                                )
                              : null,
                        ),
                      ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: leftIcon,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
