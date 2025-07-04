import 'package:dartz/dartz.dart';
import 'package:moatmat_uploader/Features/tests/domain/entities/test/test.dart';
import 'package:moatmat_uploader/Features/tests/domain/entities/video.dart';
import 'package:moatmat_uploader/Features/tests/domain/repositories/tests_repository.dart';

import '../datasources/tests_remote_ds.dart';

class TestsRepositoryImpl implements TestsRepository {
  final TestsRemoteDS dataSource;

  TestsRepositoryImpl({required this.dataSource});
  @override
  Future<Either<Exception, Stream>> uploadTest({required Test test}) async {
    try {
      return right(dataSource.uploadTest(test: test));
    } on Exception catch (e) {
      return left(e);
    }
  }

  @override
  Future<Either<Exception, Unit>> deleteTest({required int testId}) async {
    try {
      dataSource.deleteTest(testId: testId);
      return right(unit);
    } on Exception catch (e) {
      return left(e);
    }
  }

  @override
  Future<Either<Exception, List<Test>>> getTests(
      {required String material}) async {
    try {
      final res = await dataSource.getMyTests(material: material);
      return right(res);
    } on Exception catch (e) {
      return left(e);
    }
  }

  @override
  Future<Either<Exception, Test?>> getTestById(
      {required int testId, required bool update}) async {
    try {
      final res = await dataSource.getTestById(testId: testId, update: update);
      return right(res);
    } on Exception catch (e) {
      return left(e);
    }
  }

  @override
  Future<Either<Exception, Stream>> updateTest({required Test test}) async {
    try {
      return right(dataSource.updateTest(test: test));
    } on Exception catch (e) {
      return left(e);
    }
  }

  @override
  Future<Either<Exception, List<Test>>> getTestsByIds(
      {required List<int> ids, required bool update}) async {
    try {
      final res = await dataSource.getTestsByIds(ids: ids, update: update);
      return right(res);
    } on Exception catch (e) {
      return left(e);
    }
  }

  @override
  Future<Either<Exception, List<Test>>> searchTest({
    required String keyword,
  }) async {
    try {
      final res = await dataSource.searchTest(keyword: keyword);
      return right(res);
    } on Exception catch (e) {
      print(e);
      return left(e);
    }
  }

  @override
  Future<Either<Exception, Video>> addVideo({
    required Video video,
  }) async {
    try {
      var res = await dataSource.addVideo(video: video);
      return right(res);
    } on Exception catch (e) {
      return left(e);
    }
  }
}
