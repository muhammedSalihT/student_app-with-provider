import 'package:flutter/material.dart';
import 'package:studentapp/core/constands.dart';
import 'package:studentapp/widgets/widget_text.dart';

class DetailWidget extends StatelessWidget {
  const DetailWidget({
    Key? key, required this.heading, required this.content,
  }) : super(key: key);

  final String heading;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextWidget(title: heading, size: 30, weight: FontWeight.bold),
        kWidth,
        TextWidget(title: content, size: 30, weight: FontWeight.bold)
      ],
    );
  }
}
