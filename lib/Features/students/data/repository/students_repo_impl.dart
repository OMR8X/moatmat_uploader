import 'package:dartz/dartz.dart';
import 'package:moatmat_uploader/Features/banks/domain/entities/bank.dart';
import 'package:moatmat_uploader/Features/students/data/datasources/students_ds.dart';
import 'package:moatmat_uploader/Features/students/data/datasources/students_local_ds.dart';
import 'package:moatmat_uploader/Features/students/domain/entities/result.dart';
import 'package:moatmat_uploader/Features/students/domain/entities/test_details.dart';
import 'package:moatmat_uploader/Features/students/domain/entities/user_data.dart';
import 'package:moatmat_uploader/Features/students/domain/repository/students_repo.dart';
import 'package:moatmat_uploader/Features/tests/domain/entities/test/test.dart';

class StudentsRepositoryImpl implements StudentsRepository {
  final StudentsDS dataSource;
  final StudentsLocalDS localDataSource;

  StudentsRepositoryImpl(
      {required this.dataSource, required this.localDataSource});
  @override
  Future<Either<Exception, List<UserData>>> getMyStudents(
      {required bool update}) async {
    try {
      var res = await dataSource.getMyStudents(update: update);
      return right(res);
    } on Exception catch (e) {
      return left(e);
    }
  }

  @override
  Future<Either<Exception, List<UserData>>> getRepositoryStudents({
    required Test? test,
    required Bank? bank,
    required bool update,
  }) async {
    try {
      var res = await dataSource.getRepositoryStudents(
        test: test,
        bank: bank,
        update: update,
      );
      return right(res);
    } on Exception catch (e) {
      return left(e);
    }
  }

  @override
  Future<Either<Exception, List<Result>>> getStudentResults(
      {required String id, required bool update}) async {
    try {
      var res = await dataSource.getStudentResults(id: id, update: update);
      return right(res);
    } on Exception catch (e) {
      return left(e);
    }
  }

  @override
  Future<Either<Exception, List<Result>>> getRepositoryResults({
    required Test? test,
    required Bank? bank,
    required bool update,
  }) async {
    try {
      var res = await dataSource.getRepositoryResults(
        test: test,
        bank: bank,
        update: update,
      );
      return right(res);
    } on Exception catch (e) {
      return left(e);
    }
  }

  @override
  Future<Either<Exception, List<UserData>>> searchInMyStudents({
    required String text,
    required bool update,
  }) async {
    try {
      var res = await dataSource.searchInMyStudents(text: text, update: update);
      return right(res);
    } on Exception catch (e) {
      return left(e);
    }
  }

  @override
  RepositoryDetails getRepositoryDetails({
    required Test? test,
    required Bank? bank,
    required List<Result> results,
    required bool update,
  }) {
    return localDataSource.getRepositoryDetails(
      test: test,
      bank: bank,
      results: results,
    );
  }

  @override
  Future<Either<Exception, double>> getRepositoryAverage({
    required String? testId,
    required String? bankId,
    required bool update,
  }) async {
    try {
      var res = await dataSource.getRepositoryAverage(
        testId: testId,
        bankId: bankId,
        update: update,
      );
      return right(res);
    } on Exception catch (e) {
      return left(e);
    }
  }

  @override
  Future<Either<Exception, Unit>> deleteRepositoryResults({
    required List<int>? results,
    required int? testId,
    required int? bankId,
  }) async {
    try {
      await dataSource.deleteRepositoryResults(
          results: results, testId: testId);
      return right(unit);
    } on Exception catch (e) {
      return left(e);
    }
  }
}
