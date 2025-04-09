import 'package:dartz/dartz.dart';

import '../entities/test/test.dart';
import '../repositories/tests_repository.dart';

class SearchTestUC {
  final TestsRepository repository;

  SearchTestUC({required this.repository});

  Future<Either<Exception, List<Test>>> call({required String keyword}) async {
    return await repository.searchTest(keyword: keyword);
  }
}
