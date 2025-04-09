import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:moatmat_uploader/Core/functions/math/calculate_mark_f.dart';
import 'package:moatmat_uploader/Core/injection/app_inj.dart';
import 'package:moatmat_uploader/Features/students/domain/entities/test_details.dart';
import 'package:moatmat_uploader/Features/students/domain/usecases/get_repository_details_uc.dart';
import 'package:moatmat_uploader/Features/students/domain/usecases/get_repository_results_uc.dart';
import 'package:moatmat_uploader/Features/tests/domain/entities/question/question.dart';
import 'package:moatmat_uploader/Features/tests/domain/entities/test/test.dart';

import '../../../../Features/students/domain/entities/result.dart';

part 'test_results_state.dart';

class TestResultsCubit extends Cubit<TestResultsState> {
  TestResultsCubit() : super(const TestResultsLoading());
  Test? test;
  init(Test test) async {
    //
    this.test = test;
    //
    emit(const TestResultsLoading());
    //
    var res = await locator<GetRepositoryResultsUC>().call(
      test: test,
      bank: null,
      update: false,
    );
    //
    res.fold(
      (l) => emit(TestResultsError(l.toString())),
      (r) {
        //
        var details = locator<GetRepositoryDetailsUC>().call(
          test: test,
          bank: null,
          results: r,
          update: false,
        );
        //
        emit(TestResultsInitial(details: details));
      },
    );
  }

  update() async {
    //
    emit(const TestResultsLoading());
    //
    var res = await locator<GetRepositoryResultsUC>().call(
      test: test!,
      bank: null,
      update: true,
    );
    //
    res.fold(
      (l) => emit(TestResultsError(l.toString())),
      (r) {
        //
        var details = locator<GetRepositoryDetailsUC>().call(
          test: test!,
          bank: null,
          results: r,
          update: true,
        );
        //
        emit(TestResultsInitial(details: details));
      },
    );
  }
}
