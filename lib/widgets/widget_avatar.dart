import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:studentapp/infrastructure/db_functions.dart';
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
      radius: 40,
      child: StudentModelFunction().image.trim().isEmpty
          ? CircleAvatar(
              radius: 50,
              backgroundImage: MemoryImage(
                Base64Decoder().convert(model.imgstri),
              ),
            )
          : Container(
              color: Colors.white,
            ),
    );
  }
}
