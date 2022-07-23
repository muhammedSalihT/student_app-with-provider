import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  const Avatar({
    Key? key, required this.circleRadious, required this.image,
  }) : super(key: key);

  final double circleRadious;
  final String image;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
        radius: circleRadious,
        backgroundColor: const Color.fromRGBO(0, 0, 0, 0),
        backgroundImage: AssetImage(image));
  }
}
