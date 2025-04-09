import 'package:moatmat_uploader/Features/auth/domain/entites/teacher_data.dart';
import 'package:moatmat_uploader/Features/banks/domain/entities/bank.dart';
import 'package:moatmat_uploader/Features/teachers/domain/entities/teacher.dart';
import 'package:moatmat_uploader/Features/tests/domain/entities/test/test.dart';

class TeacherRequest {
  //
  int id;
  //
  final TeacherData teacherData;
  //
  final String? text;
  //
  final Bank? bank;
  //
  final Test? test;
  //
  final List<String> files;

  TeacherRequest({
    required this.id,
    this.text,
    required this.teacherData,
    this.bank,
    this.test,
    required this.files,
  });

  TeacherRequest copyWith({
    //
    int? id,
    //
    String? text,
    //
    TeacherData? teacherData,
    //
    Bank? bank,
    //
    Test? test,
    //
    List<String>? files,
  }) {
    return TeacherRequest(
      id: id ?? this.id,
      text: text ?? this.text,
      teacherData: teacherData ?? this.teacherData,
      bank: bank ?? this.bank,
      test: test ?? this.test,
      files: files ?? this.files,
    );
  }
}
