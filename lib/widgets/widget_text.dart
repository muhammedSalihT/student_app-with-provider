import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final String title;
  final double? size;
  final Color? textColor;
  final FontWeight? weight;
  const TextWidget({
    Key? key, required this.title,  this.size,  this.textColor,  this.weight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
          fontSize: size, color: textColor, fontWeight: weight),
    );
  }
}
