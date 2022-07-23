import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:studentapp/models/student_model.dart';

abstract class Student {
  Future<void> addStudent(StudentModel student);
  Future<void> getAllStudent();
  Future<void> deleteStudent(int id);
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
    print(studentlistNotifier);
    notifyListeners();
  }

  @override
  Future<void> deleteStudent(int id) async {
    final studentDb = await Hive.openBox<StudentModel>("student_db");
    studentDb.delete(id);
    getAllStudent();
    notifyListeners();
  }
}
