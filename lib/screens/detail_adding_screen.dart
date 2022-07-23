import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:studentapp/core/constands.dart';
import 'package:studentapp/infrastructure/db_functions.dart';
import 'package:studentapp/models/student_model.dart';
import 'package:studentapp/widgets/form_field_widget.dart';
import 'package:studentapp/widgets/widget_appbar.dart';
import 'package:studentapp/widgets/widget_bottombar.dart';

enum ActionType { addStudent, editStudent }

class DetailAddingScreen extends StatelessWidget {
  DetailAddingScreen({
    Key? key,
    required this.type,
  }) : super(key: key);

  final ActionType type;
  



  final _formkey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _numController = TextEditingController();
  final _placeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: WidgetAppBar(
            title: type == ActionType.addStudent ? "Add new student" :"",
            iconButton: Icons.star,
            iconColor: const Color.fromARGB(255, 236, 214, 18),
          )),
      body: SafeArea(
          child: Consumer(
            builder: (context, value, child) => ListView(
                  children: [
            Form(
                key: _formkey,
                child: Column(
                  children: [
                    kHeight3,
                    Stack(
                      children: [
                        CircleAvatar(
                            radius: 80,
                            backgroundColor: const Color.fromRGBO(0, 0, 0, 0),
                            backgroundImage: AssetImage(
                                type == ActionType.addStudent
                                    ? "images/download.png"
                                    : "images/download.jpg")),
                        Padding(
                          padding: const EdgeInsets.only(top: 100, left: 110),
                          child: IconButton(
                              onPressed: () {
                                showBottomSheet(context);
                              },
                              icon: const Icon(
                                Icons.camera_alt,
                                color: Colors.red,
                                size: 50,
                              )),
                        ),
                      ],
                    ),
                    kHeight3,
                    TextFieldWidget(
                        hint: "Enter student name", control: _nameController),
                    kHeight3,
                    TextFieldWidget(hint: "Enter age", control: _ageController),
                    kHeight3,
                    TextFieldWidget(
                        hint: "Phone number", control: _numController),
                    kHeight3,
                    TextFieldWidget(hint: "Place", control: _placeController),
                    kHeight3,
                  ],
                )),
                  ],
                ),
          )),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          if (_formkey.currentState!.validate()) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Added Alex ')),
            );
            onButtonClicked();
          }
        },
        child: BottomBarWidget(
          title: type == ActionType.addStudent ? "Save" : "update",
        ),
      ),
    );
  }

  Future showBottomSheet(context) async {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 80,
            width: double.infinity,
            color: const Color.fromARGB(62, 0, 0, 0),
            child: Column(children: [
              const Text('choise your profile photo'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () {
                        takecamera();
                      },
                      icon: const Icon(
                        Icons.camera,
                        size: 30,
                      )),
                  IconButton(
                      onPressed: () {
                        takePhoto();
                      },
                      icon: const Icon(
                        Icons.sd_storage,
                        size: 30,
                      ))
                ],
              )
            ]),
          );
        });
  }

  Future takecamera() async {
    await ImagePicker().pickImage(source: ImageSource.camera);
  }

  Future takePhoto() async {
    await ImagePicker().pickImage(source: ImageSource.gallery);
  }

  Future onButtonClicked() async {
    final name = _nameController.text;
    final age = _ageController.text;
    final phoneNumber = _numController.text;
    final place = _placeController.text;

    if (name.isEmpty || age.isEmpty || phoneNumber.isEmpty || place.isEmpty) {
      return;
    } else {
      final student = StudentModel(
          name: name,
          age: age,
          phoneNumber: phoneNumber,
          place: place,
          imgstri: "");
          
       Provider.of<StudentModelFunction>(_formkey.currentState!.context,
              listen: false)
          .addStudent(student);
    }
  }
}
