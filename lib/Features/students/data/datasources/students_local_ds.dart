import 'package:flutter/cupertino.dart';
import 'package:moatmat_uploader/Core/functions/math/calculate_mark_f.dart';
import 'package:moatmat_uploader/Features/banks/domain/entities/bank.dart';

import '../../../tests/domain/entities/question/question.dart';
import '../../../tests/domain/entities/test/test.dart';
import '../../domain/entities/result.dart';
import '../../domain/entities/test_details.dart';

abstract class StudentsLocalDS {
  RepositoryDetails getRepositoryDetails({
    required Test? test,
    required Bank? bank,
    required List<Result> results,
  });
}

class StudentsLocalDSImpl implements StudentsLocalDS {
  const StudentsLocalDSImpl();
  @override
  RepositoryDetails getRepositoryDetails({
    required Test? test,
    required Bank? bank,
    required List<Result> results,
  }) {
    //
    List<(Result, double)> marks = [];
    //
    List<Question> questions = [];
    //
    if (test != null) {
      questions = test.questions;
    }
    if (bank != null) {
      questions = bank.questions;
    }
    //
    //
    List<Map<int, int>> selectionCounts = questions.map((e) {
      return <int, int>{};
    }).toList();
    //
    for (int i = 0; i < results.length; i++) {
      final r = results[i];
      final m = calculateMarkFunction(results[i], questions);
      //
      marks.add((r, m));
      //
    }
    // {questions id : selections}
    // {q0: [0, 1, 0], q1: [0, 0, 0], q2: [0, 1, 1]}
    // where [0,1,..] is answers
    Map<int, List<int>> selectionsData = getSelectionsData(
      results,
    );
    // {questions id : selections}
    // {q0: {0: 2, 1: 1}, q1:  {0: 3}, q2: {0: 1, 1: 2}}
    // where [0,1,..] is answers
    selectionCounts = getSelectionCount(
      selectionsData: selectionsData,
      selectionCounts: selectionCounts,
    );

    // {q0: [2, 1], q1: [3, 0], q2: [1, 2]}
    // where [2, 1,..] is answers selection counts
    List<List<int>> selectionsCount = fixSelectionsCount(
      selectionCounts: selectionCounts,
      questions: questions,
    );
    // selectionsCount
    List<List<double>> selectionPercents = [];
    //
    for (var c in selectionsCount) {
      List<double> values = [];
      int sum = c.reduce((a, b) => a + b);
      if (sum == 0) {
        // If sum is zero, use 0.0 to avoid division by zero
        values = List<double>.filled(c.length, 0.0);
      } else {
        for (var l in c) {
          values.add(double.tryParse((l / sum).toStringAsFixed(2)) ?? 0.0);
        }
      }
      selectionPercents.add(values);
    }

    //
    return RepositoryDetails(
      average: calculateAverage(results: results, questions: questions),
      selectionPercents: selectionPercents,
      marks: marks,
    );
  }

  double calculateAverage({
    required List<Result> results,
    required List<Question> questions,
  }) {
    List<double> marks = results.map((e) {
      return calculateMarkFunction(e, questions);
    }).toList();
    //
    marks.removeWhere((e) => e < 0.33);
    //
    if (marks.isEmpty) {
      // Return a default value or 0.0 if no marks are left after filtering
      return 0.0;
    }
    //
    double sum = marks.fold(0, (previous, current) => previous + current);
    //
    double average = sum / marks.length; // Now marks.length will not be zero
    //
    average = double.tryParse(average.toStringAsFixed(2)) ?? 0.0;
    //
    return average;
  }

  double calculateMarkFunction(Result r, List<Question> q) {
    // Early exit if there are no questions to avoid unnecessary processing
    if (q.isEmpty) return 0.0;

    double result = 0.0;
    for (int i = 0; i < q.length; i++) {
      final question = q[i];
      List<int?> correctAnswers = [];

      for (int j = 0; j < question.answers.length; j++) {
        if (question.answers[j].trueAnswer ?? false) {
          correctAnswers.add(j);
        }
      }
      // Check if the index is valid and if the selected answer is correct
      if (i < r.answers.length && correctAnswers.contains(r.answers[i])) {
        result++;
      }
    }

    // Calculation of percentage of correct answers
    double percentage = result / q.length;
    // Formatting the result to two decimal places
    return double.parse(percentage.toStringAsFixed(2));
  }

  Map<int, List<int>> getSelectionsData(List<Result> results) {
    //
    Map<int, List<int>> selectionCountsData = {};
    //
    for (int i = 0; i < results.length; i++) {
      //
      for (int j = 0; j < results[i].answers.length; j++) {
        //
        final a = results[i].answers[j];
        // check
        if (selectionCountsData[j] == null) {
          selectionCountsData[j] = [];
        }
        //
        if (a != null) {
          selectionCountsData[j]!.add(a);
        }
      }
    }
    return selectionCountsData;
  }

  List<Map<int, int>> getSelectionCount({
    required Map<int, List<int>> selectionsData,
    required List<Map<int, int>> selectionCounts,
  }) {
    for (var key in selectionsData.keys) {
      //
      Map<int, int> selections = {};
      //
      for (var d in selectionsData[key]!) {
        //
        if (selections[d] == null) {
          selections[d] = 0;
        }
        //
        selections[d] = selections[d]! + 1;
      }
      //
      selectionCounts[key] = selections;
    }
    return selectionCounts;
  }

  List<List<int>> fixSelectionsCount({
    required List<Map<int, int>> selectionCounts,
    required List<Question> questions,
  }) {
    List<List<int>> selectionsCount = [];
    //
    for (int i = 0; i < selectionCounts.length; i++) {
      //
      List<int> values = [];
      //
      values = questions[i].answers.map((e) => 0).toList();
      //
      for (var v in selectionCounts[i].keys) {
        values[v] = selectionCounts[i][v]!;
      }
      //
      selectionsCount.add(values);
    }
    return selectionsCount;
  }
}
