import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:studentapp/models/student_model.dart';

class Avatar extends StatelessWidget {
  const Avatar({
    Key? key,
    required this.circleRadious,
    required this.model,
  }) : super(key: key);

  final double circleRadious;
  final StudentModel model;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: circleRadious,
      child: model.imgstri.isNotEmpty
          ? CircleAvatar(
            radius: circleRadious,
              backgroundImage: MemoryImage(
                Base64Decoder().convert(model.imgstri),
              ),
            )
          :  CircleAvatar(
            radius: circleRadious,
             backgroundImage: AssetImage("images/download.png"),
            ),
    );
  }
}
