import 'package:flutter/foundation.dart';
import 'package:studentmanagement/functions/db_functions.dart';
import 'package:studentmanagement/model/student_model.dart';

class Controller extends ChangeNotifier {
  List<StudentModel> studentList = [];
  List<StudentModel> studentSearchList = [];

  void getAllStudent() async {
    studentList.clear();
    final students = await getAllStudents();
    studentList.addAll(students);
    studentSearchList = List.from(studentList);
    notifyListeners();
  }

  void searchStudents(String words) {
    if (words.isEmpty) {
      studentSearchList = List.from(studentList);
    } else {
      studentSearchList = studentList.where((student) {
        final nameLower = student.name.toLowerCase();
        final searchLower = words.toLowerCase();
        return nameLower.contains(searchLower);
      }).toList();
    }
    notifyListeners();
  }
}
