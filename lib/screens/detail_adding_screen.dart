import 'dart:io';

import 'package:camera/camera.dart';
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
    this.data, required this.camera,
  }) : super(key: key);

  final ActionType type;
  final StudentModel? data;

  final CameraDescription camera;

  final _formkey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _numController = TextEditingController();
  final _placeController = TextEditingController();

  File? pick;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<StudentModelFunction>(context, listen: false).getAllStudent();
    });
    if (type == ActionType.editStudent) {
      _nameController.text = data!.name;
      _ageController.text = data!.age;
      _numController.text = data!.phoneNumber;
      _placeController.text = data!.place;
    }
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: WidgetAppBar(
            title:
                type == ActionType.addStudent ? "Add new student" : data!.name,
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
                        pick != null
                            ? CircleAvatar(
                                radius: 80,
                                backgroundColor:
                                    const Color.fromRGBO(0, 0, 0, 0),
                                child: Image.file(pick!))
                            : Container(
                                child: Image.asset("images/download.png"),
                              ),
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
          print("object");
          switch (type) {
            case ActionType.addStudent:
              if (_formkey.currentState!.validate()) {
                ScaffoldMessenger.of(_formkey.currentState!.context)
                    .showSnackBar(
                  SnackBar(
                      content: Text(
                          "Student${_nameController.text}  added to Students")),
                );
                onSaveButtonClicked();
              }

              break;
            case ActionType.editStudent:
              if (_formkey.currentState!.validate()) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Student ${data!.name} editted")));
              }
              onUpdateButtonClicked();
              break;
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
    XFile? pickImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    print(pickImage);
    if (pickImage == null) {
      return;
    }

    File temp = File(pickImage.path);
    print("hi$pick");
    pick = temp;

    Provider.of<StudentModelFunction>(_formkey.currentState!.context,
            listen: false)
        .imageadd(pickImage);
  }

  Future takePhoto() async {
    await ImagePicker().pickImage(source: ImageSource.gallery);
  }

  Future onSaveButtonClicked() async {
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
          imgstri: StudentModelFunction().image);
      Provider.of<StudentModelFunction>(_formkey.currentState!.context,
              listen: false)
          .addStudent(student);
      Navigator.of(_formkey.currentContext!).pop();
    }
  }

  void onUpdateButtonClicked() {
    final nameEditted = _nameController.text;
    final ageEditted = _ageController.text;
    final phoneNumberEditted = _numController.text;
    final placeEditted = _placeController.text;

    if (nameEditted.isEmpty ||
        ageEditted.isEmpty ||
        phoneNumberEditted.isEmpty ||
        placeEditted.isEmpty) {
      return;
    } else {
      final studentEditted = StudentModel(
          name: nameEditted,
          age: ageEditted,
          phoneNumber: phoneNumberEditted,
          place: placeEditted,
          imgstri: "",
          id: data!.id);
      Provider.of<StudentModelFunction>(_formkey.currentState!.context,
              listen: false)
          .updateStudent(studentEditted.id!, studentEditted);
      Navigator.of(_formkey.currentContext!).pop();
    }
  }
}
