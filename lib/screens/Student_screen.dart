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
  const StudentScreen({Key? key, required this.studentList}) : super(key: key);

  final StudentModel studentList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: WidgetAppBar(
            title: "Alex",
            iconButton: Icons.star,
            iconColor: Color.fromARGB(255, 236, 214, 18),
          )),
      body: ListView(
        children:  [
          kHeight1,
          Center(
              child: Avatar(
            circleRadious: 120,
            image: "images/download.jpg",
          )),
          kHeight1,
          DetailWidget(heading: "Name:", content:studentList.name ),
          kHeight2,
          DetailWidget(
            heading: "Age:",
            content: "24",
          ),
          kHeight2,
          DetailWidget(
            heading: "Phone:",
            content: "685865",
          ),
          kHeight2,
          DetailWidget(
            heading: "Place:",
            content: "Us",
          ),
        ],
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => DetailAddingScreen(
            type: ActionType.editStudent,
          ),
        )),
        child: const BottomBarWidget(
          title: "Edit Details",
        ),
      ),
    );
  }
}
