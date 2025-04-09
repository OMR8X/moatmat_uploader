import 'package:dartz/dartz.dart';
import 'package:moatmat_uploader/Features/tests/domain/entities/test/test.dart';

abstract class TestsRepository {
  //
  Future<Either<Exception, Stream>> uploadTest({
    required Test test,
  });
  //
  Future<Either<Exception, Stream>> updateTest({
    required Test test,
  });
  //
  Future<Either<Exception, Unit>> deleteTest({
    required int testId,
  });
  //
  Future<Either<Exception, Test?>> getTestById({
    required int testId,
    required bool update,
  });
  //
  Future<Either<Exception, List<Test>>> getTestsByIds({
    required List<int> ids,
    required bool update,
  });
  //
  Future<Either<Exception, List<Test>>> getTests({
    required String material,
  });
  //
  Future<Either<Exception, List<Test>>> searchTest({
    required String keyword,
  });
}
