import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:studentapp/core/constands.dart';
import 'package:studentapp/infrastructure/db_functions.dart';
import 'package:studentapp/models/student_model.dart';
import 'package:studentapp/screens/detail_adding_screen.dart';
import 'package:studentapp/widgets/datails_widget.dart';
import 'package:studentapp/widgets/widget_appbar.dart';
import 'package:studentapp/widgets/widget_avatar.dart';
import 'package:studentapp/widgets/widget_bottombar.dart';

class StudentScreen extends StatelessWidget {
  const StudentScreen({Key? key, required this.studentList, required this.cam2}) : super(key: key);

  final StudentModel studentList;

  final CameraDescription cam2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: WidgetAppBar(
            title: studentList.name,
            iconButton: Icons.star,
            iconColor: const Color.fromARGB(255, 236, 214, 18),
          )),
      body: ListView(
        children: [
          kHeight1,
          Center(child: Avatar(circleRadious: 30.0, model: studentList)),
          kHeight1,
          DetailWidget(heading: "Name:", content: studentList.name),
          kHeight2,
          DetailWidget(
            heading: "Age:",
            content: studentList.age,
          ),
          kHeight2,
          DetailWidget(
            heading: "Phone:",
            content: studentList.phoneNumber,
          ),
          kHeight2,
          DetailWidget(
            heading: "Place:",
            content: studentList.place,
          ),
        ],
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => DetailAddingScreen(
            type: ActionType.editStudent,
            data: studentList,
            camera: cam2,
          ),
        )),
        child: const BottomBarWidget(
          title: "Edit Details",
        ),
      ),
    );
  }
}
