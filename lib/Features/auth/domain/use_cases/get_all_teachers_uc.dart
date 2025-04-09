import 'package:dartz/dartz.dart';

import '../entites/teacher_data.dart';
import '../repository/teachers_repository.dart';

class GetAllTeachersUC {
  final TeacherRepository repository;

  GetAllTeachersUC({required this.repository});

  Future<Either<Exception, List<TeacherData>>> call() {
    return repository.getALlTeachers();
  }
}
