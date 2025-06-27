import 'package:dartz/dartz.dart';
import 'package:moatmat_uploader/Features/school/domain/entities/school.dart';

import '../../../../Core/errors/exceptions.dart';

abstract class SchoolRepository {
  Future<Either<Failure, List<School>>> getSchool();
}
