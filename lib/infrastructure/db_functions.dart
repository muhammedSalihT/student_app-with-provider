import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:studentapp/models/student_model.dart';

abstract class Student {
  Future<void> addStudent(StudentModel student);
  Future<void> getAllStudent();
  Future<void> deleteStudent(int id);
  Future<void> updateStudent(int id, StudentModel studentEditted);
}

class StudentModelFunction extends Student with ChangeNotifier {
  List<StudentModel> studentlistNotifier = [];

  @override
  Future<void> addStudent(StudentModel student) async {
    final studentDb = await Hive.openBox<StudentModel>("student_db");

    final _id = await studentDb.add(student);

    student.id = _id;
    await studentDb.put(student.id, student);
    getAllStudent();
    notifyListeners();
  }

  @override
  Future<void> getAllStudent() async {
    final studentDb = await Hive.openBox<StudentModel>("student_db");
    studentlistNotifier.clear();
    studentlistNotifier.addAll(studentDb.values);
    notifyListeners();
  }

  @override
  Future<void> deleteStudent(int id) async {
    final studentDb = await Hive.openBox<StudentModel>("student_db");
    studentDb.delete(id);
    getAllStudent();
    notifyListeners();
  }

  @override
  Future<void> updateStudent(int id, StudentModel studentEditted) async {
    final studentDb = await Hive.openBox<StudentModel>("student_db");
    studentDb.put(id, studentEditted);
    getAllStudent();
  }

  String image = "";

  imageadd(XFile? file) {
    if (file == null) {
      return "images/download.png";
    } else {
      final bayts = File(file.path).readAsBytesSync();
      image = base64Encode(bayts);
      print("hleo$image");
    }
    notifyListeners();
  }
}
