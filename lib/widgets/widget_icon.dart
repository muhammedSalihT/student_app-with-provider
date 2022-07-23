import 'package:flutter/material.dart';

class IconWidget extends StatelessWidget {
  const IconWidget({
    Key? key,
    required this.onpressing,
    required this.button,  this.color,
  }) : super(key: key);

  final VoidCallback onpressing;
  final IconData button;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return IconButton(
       onPressed: onpressing,
        icon: Icon(
          button,
          color: color,
        ));
  }
}
