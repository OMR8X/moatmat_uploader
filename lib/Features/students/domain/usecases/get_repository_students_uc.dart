import 'package:dartz/dartz.dart';

import '../../../banks/domain/entities/bank.dart';
import '../../../tests/domain/entities/test/test.dart';
import '../entities/user_data.dart';
import '../repository/students_repo.dart';

class GetRepositoryStudentsUC {
  final StudentsRepository repository;

  GetRepositoryStudentsUC({required this.repository});

  Future<Either<Exception, List<UserData>>> call({
    required Test? test,
    required Bank? bank,
    required bool update,
  }) {
    return repository.getRepositoryStudents(
      test: test,
      bank: bank,
      update: update,
    );
  }
}
