import 'package:moatmat_uploader/Features/students/data/datasources/students_ds.dart';
import 'package:moatmat_uploader/Features/students/data/repository/students_repo_impl.dart';
import 'package:moatmat_uploader/Features/students/domain/repository/students_repo.dart';
import 'package:moatmat_uploader/Features/students/domain/usecases/delete_results_uc.dart';
import 'package:moatmat_uploader/Features/students/domain/usecases/get_my_students_uc.dart';
import 'package:moatmat_uploader/Features/students/domain/usecases/get_student_results_uc.dart';
import 'package:moatmat_uploader/Features/students/domain/usecases/get_repository_average_uc.dart';
import 'package:moatmat_uploader/Features/students/domain/usecases/get_repository_results_uc.dart';
import 'package:moatmat_uploader/Features/students/domain/usecases/get_repository_students_uc.dart';
import 'package:moatmat_uploader/Features/students/domain/usecases/search_in_my_students_uc.dart';

import '../../Features/students/data/datasources/students_local_ds.dart';
import '../../Features/students/domain/usecases/get_repository_details_uc.dart';
import 'app_inj.dart';

injectStudents() {
  injectDS();
  injectRepo();
  injectUC();
}

void injectUC() {
  locator.registerFactory<GetMyStudentsUC>(
    () => GetMyStudentsUC(
      repository: locator(),
    ),
  );
  locator.registerFactory<GetStudentResultsUC>(
    () => GetStudentResultsUC(
      repository: locator(),
    ),
  );
  locator.registerFactory<GetRepositoryResultsUC>(
    () => GetRepositoryResultsUC(
      repository: locator(),
    ),
  );
  locator.registerFactory<SearchInMyStudentsUC>(
    () => SearchInMyStudentsUC(
      repository: locator(),
    ),
  );
  locator.registerFactory<GetRepositoryDetailsUC>(
    () => GetRepositoryDetailsUC(
      repository: locator(),
    ),
  );
  locator.registerFactory<GetRepositoryStudentsUC>(
    () => GetRepositoryStudentsUC(
      repository: locator(),
    ),
  );
  locator.registerFactory<GetRepositoryAverageUC>(
    () => GetRepositoryAverageUC(
      repository: locator(),
    ),
  );
  locator.registerFactory<DeleteResultsUC>(
    () => DeleteResultsUC(
      repository: locator(),
    ),
  );
}

void injectRepo() {
  locator.registerFactory<StudentsRepository>(
    () => StudentsRepositoryImpl(
      dataSource: locator(),
      localDataSource: locator(),
    ),
  );
}

void injectDS() {
  locator.registerFactory<StudentsDS>(
    () => const StudentsDSimpl(),
  );
  locator.registerFactory<StudentsLocalDS>(
    () => const StudentsLocalDSImpl(),
  );
}
