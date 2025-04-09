import 'package:dartz/dartz.dart';
import 'package:moatmat_uploader/Features/students/domain/entities/user_data.dart';

import '../../../../../Core/errors/exceptions.dart';
import '../entites/teacher_data.dart';

abstract class TeacherRepository {
  // signIn
  Future<Either<Failure, TeacherData>> signIn({
    required String email,
    required String password,
  });
  // signUp
  Future<Either<Failure, TeacherData>> signUp({
    required TeacherData teacherData,
    required String password,
  });
  //
  // update Teacher Data
  Future<Either<Failure, Unit>> updateTeacherData({
    required TeacherData teacherData,
  });
  //
  //
  Future<Either<Exception, List<TeacherData>>> getALlTeachers();
  //
  // get Teacher Data
  Future<Either<Failure, TeacherData>> getTeacherData({String? email});
  // get user Data
  Future<Either<Failure, UserData>> getUserDataData({required String id});
}
