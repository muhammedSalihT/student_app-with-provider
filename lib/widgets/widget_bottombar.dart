import 'package:flutter/material.dart';
import 'package:studentapp/widgets/widget_text.dart';

class BottomBarWidget extends StatelessWidget {
  const BottomBarWidget({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;


  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.orangeAccent,
        child: SizedBox(
          height: 56,
          width: double.infinity,
          child: Center(
            child: TextWidget(
              title: title,
              weight: FontWeight.bold,
              size: 25,
            ),
          ),
        ));
  }
}
