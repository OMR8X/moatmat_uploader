import 'package:moatmat_uploader/Features/students/domain/entities/test_details.dart';
import 'package:moatmat_uploader/Features/students/domain/repository/students_repo.dart';

import '../../../banks/domain/entities/bank.dart';
import '../../../tests/domain/entities/test/test.dart';
import '../entities/result.dart';

class GetRepositoryDetailsUC {
  final StudentsRepository repository;

  GetRepositoryDetailsUC({required this.repository});

  RepositoryDetails call({
    required Test? test,
    required Bank? bank,
    required List<Result> results,
    required bool update,
  }) {
    return repository.getRepositoryDetails(
      test: test,
      bank: bank,
      results: results,
      update: update,
    );
  }
}
