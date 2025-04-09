import 'package:dartz/dartz.dart';
import 'package:moatmat_uploader/Features/students/domain/entities/result.dart';
import 'package:moatmat_uploader/Features/students/domain/entities/test_details.dart';
import 'package:moatmat_uploader/Features/students/domain/entities/user_data.dart';
import 'package:moatmat_uploader/Features/tests/domain/entities/test/test.dart';

import '../../../banks/domain/entities/bank.dart';

abstract class StudentsRepository {
  //
  // get my students
  Future<Either<Exception, List<UserData>>> getMyStudents({
    required bool update,
  });
  // get test students
  Future<Either<Exception, List<UserData>>> getRepositoryStudents({
    required Test? test,
    required Bank? bank,
    required bool update,
  });
  //
  // search in my students
  Future<Either<Exception, List<UserData>>> searchInMyStudents({
    required String text,
    required bool update,
  });
  //
  // get student results
  Future<Either<Exception, List<Result>>> getStudentResults({
    required String id,
    required bool update,
  });
  //
  // get test results
  Future<Either<Exception, List<Result>>> getRepositoryResults({
    required Test? test,
    required Bank? bank,
    required bool update,
  });
  // delete results
  Future<Either<Exception, Unit>> deleteRepositoryResults({
    required List<int>? results,
    required int? bankId,
    required int? testId,
  });
  //
  RepositoryDetails getRepositoryDetails({
    required Test? test,
    required Bank? bank,
    required List<Result> results,
    required bool update,
  });
  //
  Future<Either<Exception, double>> getRepositoryAverage({
    required String? testId,
    required String? bankId,
    required bool update,
  });
}
