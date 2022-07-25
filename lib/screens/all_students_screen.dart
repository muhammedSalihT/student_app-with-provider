import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentapp/core/color.dart';
import 'package:studentapp/infrastructure/db_functions.dart';
import 'package:studentapp/screens/detail_adding_screen.dart';
import 'package:studentapp/widgets/widget_appbar.dart';
import 'package:studentapp/widgets/widget_avatar.dart';
import 'package:studentapp/widgets/widget_icon.dart';
import '../widgets/widget_bottombar.dart';
import '../widgets/widget_text.dart';
import 'Student_screen.dart';

class AllStudentsScreen extends StatelessWidget {
  const AllStudentsScreen({Key? key, required this.cam}) : super(key: key);

  final CameraDescription cam;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<StudentModelFunction>(context, listen: false).getAllStudent();
    });

    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: WidgetAppBar(
            title: "All Students",
            iconButton: Icons.search,
            iconColor: Colors.white,
          )),
      body: Consumer<StudentModelFunction>(
        builder: (context, value, child) => ListView.separated(
          itemCount: value.studentlistNotifier.length,
          separatorBuilder: (BuildContext context, int index) => const Divider(
            thickness: 5.0,
            height: 10.0,
            color: Colors.black,
          ),
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: ((context) => StudentScreen(
                    cam2: cam,
                        studentList: value.studentlistNotifier[index],
                      )))),
              child: ListTile(
                leading: Avatar(
                  model: value.studentlistNotifier[index],
                  circleRadious: 30,
                ),
                title: TextWidget(title: value.studentlistNotifier[index].name),
                subtitle:
                    TextWidget(title: value.studentlistNotifier[index].age),
                trailing: IconWidget(
                  onpressing: () {
                    print('object');
                    Provider.of<StudentModelFunction>(context, listen: false)
                        .deleteStudent(value.studentlistNotifier[index].id!);
                  },
                  button: Icons.delete,
                  color: kColorRed,
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => DetailAddingScreen(
            camera: cam,
            type: ActionType.addStudent,
          ),
        )),
        child: const BottomBarWidget(
          title: "Add Student",
        ),
      ),
    );
  }
}
