class Result {
  //
  final int id;
  //
  final String userId;
  //
  final double mark;
  //
  final int? testId;
  //
  final int? bankId;
  //
  final List<int?> answers;
  //
  final List<int?> wrongAnswers;
  //
  final DateTime date;
  //
  final int period;
  //
  final String testName;
  //
  final String userName;
  //
  final double? testAverage;
    //
  final String? teacherEmail;

  Result({
    required this.id,
    required this.userId,
    required this.testId,
    required this.bankId,
    required this.mark,
    required this.answers,
    required this.wrongAnswers,
    required this.date,
    required this.period,
    required this.testName,
    required this.userName,
    this.testAverage,
    this.teacherEmail,
  });

}
