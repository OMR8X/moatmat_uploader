import 'package:moatmat_uploader/Features/students/domain/entities/result.dart';

class RepositoryDetails {
  final double average;
  final List<List<double>> selectionPercents;
  final List<(Result, double)> marks;

  RepositoryDetails({
    required this.average,
    required this.selectionPercents,
    required this.marks,
  });
}
