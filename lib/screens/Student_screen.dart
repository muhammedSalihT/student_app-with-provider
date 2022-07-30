import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentapp/core/constands.dart';
import 'package:studentapp/infrastructure/db_functions.dart';
import 'package:studentapp/screens/detail_adding_screen.dart';
import 'package:studentapp/widgets/datails_widget.dart';
import 'package:studentapp/widgets/widget_appbar.dart';
import 'package:studentapp/widgets/widget_avatar.dart';
import 'package:studentapp/widgets/widget_bottombar.dart';

class StudentScreen extends StatelessWidget {
  const StudentScreen({
    Key? key, required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return Consumer<StudentModelFunction>(
      builder: (context, value, child) => Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: WidgetAppBar(
              title: value.studentlistNotifier[index].name,
              iconButton: Icons.star,
              iconColor: const Color.fromARGB(255, 236, 214, 18),
            )),
        body: ListView(
          children: [
            kHeight1,
            Center(
              child: Consumer<StudentModelFunction>(
                  builder: (context, value, child) =>
                      Avatar(circleRadious: 100.0, model: value.studentlistNotifier[index])),
            ),
            kHeight1,
            DetailWidget(heading: "Name:", content:value.studentlistNotifier[index].name),
            kHeight2,
            DetailWidget(
              heading: "Age:",
              content: value.studentlistNotifier[index].age,
            ),
            kHeight2,
            DetailWidget(
              heading: "Phone:",
              content: value.studentlistNotifier[index].phoneNumber,
            ),
            kHeight2,
            DetailWidget(
              heading: "Place:",
              content: value.studentlistNotifier[index].place,
            ),
          ],
        ),
        bottomNavigationBar: GestureDetector(
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => DetailAddingScreen(
              type: ActionType.editStudent,
              data: value.studentlistNotifier[index],
            ),
          )),
          child: const BottomBarWidget(
            title: "Edit Details",
          ),
        ),
      ),
    );
  }
}
