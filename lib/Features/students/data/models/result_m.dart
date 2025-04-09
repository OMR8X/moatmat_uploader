import '../../domain/entities/result.dart';

class ResultModel extends Result {
  ResultModel({
    required super.id,
    required super.answers,
    required super.wrongAnswers,
    required super.mark,
    required super.period,
    required super.date,
    required super.userId,
    required super.testId,
    required super.bankId,
    required super.testName,
    required super.userName,
    super.testAverage,
    super.teacherEmail,
  });
  factory ResultModel.fromJson(Map json) {
    return ResultModel(
      id: json["id"],
      mark: json["mark"] + 0.0,
      answers: json["answers"].cast<int?>(),
      wrongAnswers: (json["wrong_answers"] ?? []).cast<int?>(),
      period: json["period"],
      date: DateTime.parse(json["date"]),
      testName: json["test_name"],
      userId: json["user_id"],
      testId: json["test_id"] == null ? null : int.parse(json["test_id"]),
      bankId: json["bank_id"] == null ? null : int.parse(json["bank_id"]),
      userName: json["user_name"],
      teacherEmail: json["teacher_email"],
    );
  }
  factory ResultModel.fromClass(Result result) {
    return ResultModel(
      id: result.id,
      mark: result.mark,
      answers: result.answers,
      wrongAnswers: result.wrongAnswers,
      period: result.period,
      date: result.date,
      testName: result.testName,
      userId: result.userId,
      testId: result.testId,
      bankId: result.bankId,
      userName: result.userName,
      teacherEmail: result.teacherEmail,
    );
  }
  toJson() {
    return {
      "user_id": userId,
      "mark": mark,
      "test_id": testId,
      "bank_id": bankId,
      "answers": answers,
      "wrong_answers": wrongAnswers,
      "period": period,
      "date": date.toString(),
      "test_name": testName,
      "user_name": userName,
      "teacher_email": teacherEmail,
    };
  }
}
