import 'package:dartz/dartz.dart';
import 'package:moatmat_uploader/Features/students/domain/entities/user_data.dart';

import '../../../../../Core/errors/exceptions.dart';
import '../entites/teacher_data.dart';
import '../repository/teachers_repository.dart';

class GetUserDataUC {
  final TeacherRepository repository;

  GetUserDataUC({required this.repository});
  Future<Either<Failure, UserData>> call({required String id}) async {
    return await repository.getUserDataData(id: id);
  }
}
