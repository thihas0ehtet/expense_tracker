import 'package:expense/widgets/widgets.dart';
import 'package:flutter/material.dart';

class InputSelect extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final Function selectAction;
  final bool showCancelButton;
  final bool disableMargin;
  final Function cancelAction;
  const InputSelect(
      {Key? key,
      required this.label,
      required this.controller,
      required this.selectAction,
      required this.showCancelButton,
      required this.cancelAction,
      this.disableMargin = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InputField(
      context,
      label: label,
      disableMargin: disableMargin,
      widget: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute<void>(
                    builder: (BuildContext context) {
                      return selectAction();
                    },
                    fullscreenDialog: true));
              },
              child: TextField(
                controller: controller,
                enabled: false,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          if (showCancelButton)
            IconButton(
                onPressed: () => cancelAction(),
                icon: Icon(
                  Icons.highlight_off,
                  color: Colors.grey.shade500,
                ))
        ],
      ),
    );
  }
}
