import 'package:flutter/material.dart';

class InputText extends StatelessWidget {
  const InputText({Key? key, required this.iniVal, required this.hint, required this.label, required this.type, required this.enable}) : super(key: key);

  final String iniVal;
  final String hint;
  final String label;
  final String type;
  final bool enable;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: iniVal,
      enabled: enable,
      keyboardType:
        (type == 'email') ? TextInputType.emailAddress :
        (type == "phone") ? TextInputType.phone :
        TextInputType.text,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: hint,
        labelText: label,
      ),
    );
  }
}
