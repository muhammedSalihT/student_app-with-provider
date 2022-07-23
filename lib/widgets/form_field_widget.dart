import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
 const TextFieldWidget({
    Key? key,
    required this.hint, required this.control,
  }) : super(key: key);

  final TextEditingController control;

  final String hint;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
      controller: control,
      decoration:
          InputDecoration(hintText: hint, border: const OutlineInputBorder()),
    );
  }
}
