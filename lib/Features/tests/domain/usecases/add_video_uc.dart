
import 'package:dartz/dartz.dart';
import 'package:moatmat_uploader/Features/tests/domain/entities/video.dart';
import 'package:moatmat_uploader/Features/tests/domain/repositories/tests_repository.dart';

class AddVideoUc {
  final TestsRepository repository;

  AddVideoUc({required this.repository});

  Future<Either<Exception, int>> call({
    required Video video,
  }) async {
    return await repository.addVideo(
      video: video,
    );
  }
}