import 'package:dartz/dartz.dart';
import 'package:moatmat_uploader/Features/students/domain/repository/students_repo.dart';

class GetRepositoryAverageUC {
  final StudentsRepository repository;

  GetRepositoryAverageUC({required this.repository});

  Future<Either<Exception, double>> call({
    required String? testId,
    required String? bankId,
    required bool update,
  }) {
    return repository.getRepositoryAverage(
      testId: testId,
      bankId: bankId,
      update: update,
    );
  }
}
