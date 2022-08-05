import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentapp/core/color.dart';
import 'package:studentapp/infrastructure/db_functions.dart';
import 'package:studentapp/infrastructure/image_controller.dart';
import 'package:studentapp/screens/detail_adding_screen.dart';
import 'package:studentapp/widgets/widget_appbar.dart';
import 'package:studentapp/widgets/widget_avatar.dart';
import 'package:studentapp/widgets/widget_icon.dart';
import '../widgets/widget_bottombar.dart';
import '../widgets/widget_text.dart';
import 'Student_screen.dart';

class AllStudentsScreen extends StatelessWidget {
  const AllStudentsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<StudentModelFunction>(context, listen: false).getAllStudent();
    });
    return  Scaffold(
        body: CustomScrollView(
          slivers: [
            const SliverAppBar(
              pinned: true,
              snap: true,
              floating: true,
              expandedHeight: 170,
              flexibleSpace: FlexibleSpaceBar(
                title: Text("data"),
              ),
            ),
            Consumer<StudentModelFunction>(
              builder: (context, value, child) => SliverList(
                  delegate: SliverChildBuilderDelegate(
                childCount: value.studentlistNotifier.length,
                (context, index) => GestureDetector(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: ((context) => StudentScreen(
                            index: index,
                          )))),
                  child: Container(
                    child: Row(
                      children: [
                        Consumer<ImageController>(
                          builder: (context, image, child) => Avatar(
                            model: value.studentlistNotifier[index],
                            circleRadious: 30,
                          ),
                        ),
                        Column(
                          children: [
                            TextWidget(
                                title: value.studentlistNotifier[index].name),
                            TextWidget(
                                title: value.studentlistNotifier[index].age),
                          ],
                        ),
                        IconWidget(
                          onpressing: () {
                            Provider.of<StudentModelFunction>(context,
                                    listen: false)
                                .deleteStudent(
                                    value.studentlistNotifier[index].id!);
                          },
                          button: Icons.delete,
                          color: kColorRed,
                        ),
                      ],
                    ),
                  ),
                ),
              )),
            )
          ],
        ),
        bottomNavigationBar: GestureDetector(
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => DetailAddingScreen(
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
