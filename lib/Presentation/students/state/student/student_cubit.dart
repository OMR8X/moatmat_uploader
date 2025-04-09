import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:moatmat_uploader/Core/injection/app_inj.dart';
import 'package:moatmat_uploader/Features/auth/domain/use_cases/get_user_data.dart';
import 'package:moatmat_uploader/Features/banks/domain/usecases/get_bank_by_id_uc.dart';
import 'package:moatmat_uploader/Features/students/domain/entities/user_data.dart';
import 'package:moatmat_uploader/Features/students/domain/usecases/delete_results_uc.dart';
import 'package:moatmat_uploader/Features/students/domain/usecases/get_student_results_uc.dart';
import 'package:moatmat_uploader/Features/students/domain/usecases/get_repository_average_uc.dart';
import 'package:moatmat_uploader/Features/students/domain/usecases/get_repository_results_uc.dart';
import 'package:moatmat_uploader/Features/tests/domain/entities/question/question.dart';
import 'package:moatmat_uploader/Features/tests/domain/entities/test/test.dart';
import 'package:moatmat_uploader/Features/tests/domain/usecases/get_test_by_id_uc.dart';

import '../../../../Features/banks/domain/entities/bank.dart';
import '../../../../Features/students/domain/entities/result.dart';

part 'student_state.dart';

class StudentCubit extends Cubit<StudentState> {
  StudentCubit() : super(StudentLoading());
  //
  Test? test;
  //
  Bank? bank;
  //
  String? id;
  //
  UserData? userData;
  //
  List<Result>? results;
  //
  double testAverage = 0.0;
  //
  double bankAverage = 0.0;
  //
  init({required String id, Result? result}) async {
    //
    this.id = id;
    //
    emit(StudentLoading());
    //
    var res1 = await locator<GetStudentResultsUC>().call(id: id, update: false);
    //
    var res2 = await locator<GetUserDataUC>().call(id: id);
    //
    //
    res1.fold(
      (l) => emit(StudentError(error: l.toString())),
      (r) {
        results = r;
      },
    );
    //
    res2.fold(
      (l) => emit(StudentError(error: l.toString())),
      (r) {
        userData = r;
      },
    );
    //

    if (userData != null) {
      if (results != null) {
        if (result != null) {
          showResultDetails(result);
        } else {
          emit(StudentInitial(results: results!, userData: userData!));
        }
      }
    }
  }

  showResultDetails(Result result) async {
    //
    emit(StudentLoading());
    if (result.testId != null) {
      //
      var res = await locator<GetTestByIdUC>().call(
        testId: result.testId!,
        update: true,
      );

      //
      res.fold(
        (l) {
          emit(StudentError(error: l.toString()));
        },
        (test) async {
          //
          this.test = test;
          //
          var res2 = await locator<GetRepositoryAverageUC>().call(
            testId: (test?.id ?? -1).toString(),
            bankId: null,
            update: true,
          );

          //
          res2.fold((l) => print(l), (r) {
            testAverage = r;
          });
          //
          List<(Question, int?)> wrongAnswers = [];
          //
          for (int i = 0; i < result.answers.length; i++) {
            //
            final answer = result.answers[i];
            final question = test!.questions[i];
            //
            if (answer != null) {
              //
              List<int> trueAnswers = getTrueAnswers(question);
              //
              if (!trueAnswers.contains(answer)) {
                wrongAnswers.add((question, answer));
              }
              //
            } else {
              wrongAnswers.add((question, null));
            }
          }
          //
          emit(
            StudentResultDetails(
              test: test!,
              bank: null,
              testAverage: testAverage,
              result: result,
              userData: userData!,
              wrongAnswers: wrongAnswers,
            ),
          );
        },
      );
    } //
    var res = await locator<GetBankByIdUC>().call(
      bankId: result.bankId!,
      update: true,
    );

    //
    res.fold(
      (l) {
        emit(StudentError(error: l.toString()));
      },
      (bank) async {
        //
        this.bank = bank;
        //
        var res2 = await locator<GetRepositoryAverageUC>().call(
          testId: null,
          bankId: (bank?.id ?? -1).toString(),
          update: true,
        );

        //
        res2.fold((l) => print(l), (r) {
          bankAverage = r;
        });
        //
        List<(Question, int?)> wrongAnswers = [];
        //
        for (int i = 0; i < result.answers.length; i++) {
          //
          final answer = result.answers[i];
          final question = bank!.questions[i];
          //
          if (answer != null) {
            //
            List<int> trueAnswers = getTrueAnswers(question);
            //
            if (!trueAnswers.contains(answer)) {
              wrongAnswers.add((question, answer));
            }
            //
          } else {
            wrongAnswers.add((question, null));
          }
        }
        //
        emit(
          StudentResultDetails(
            bank: bank!,
            test: null,
            testAverage: testAverage,
            result: result,
            userData: userData!,
            wrongAnswers: wrongAnswers,
          ),
        );
      },
    );
  }

  deleteResult(List<int>? results) async {
    //
    emit(StudentLoading());
    //
    await locator<DeleteResultsUC>().call(
      results: results,
    );
    //
    init(id: id!);
  }

  deleteTestResults(List<int>? results) async {
    //
    emit(StudentLoading());
    //
    await locator<DeleteResultsUC>().call(
      testId: test?.id,
    );
    //
    init(id: id!);
  }

  pop() {
    emit(StudentInitial(results: results!, userData: userData!));
  }

  List<int> getTrueAnswers(Question q) {
    //
    List<int> trueAnswers = [];
    //
    for (var answer in q.answers) {
      if (answer.trueAnswer ?? false) {
        trueAnswers.add(answer.id);
      }
    }
    //
    return trueAnswers;
  }
}
