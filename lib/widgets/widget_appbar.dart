import 'package:flutter/material.dart';
import 'package:studentapp/widgets/widget_icon.dart';
import 'package:studentapp/widgets/widget_text.dart';

class WidgetAppBar extends StatelessWidget {
  const WidgetAppBar({
    Key? key,
    required this.title,
    required this.iconButton, required this.iconColor,
  }) : super(key: key);

  final String title;
  final IconData iconButton;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return  CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: false,
          snap: false,
          floating: false,
          expandedHeight: 160,
          backgroundColor: Colors.black,
      title: TextWidget(title: title.toUpperCase()),
      centerTitle: true,
      actions: <Widget>[
        IconWidget(
          onpressing: () {},
          button: iconButton,
          color: iconColor,
        )
      ],
        )

      ],
    );
  }
}
