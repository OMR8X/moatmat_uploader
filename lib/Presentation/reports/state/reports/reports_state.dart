part of 'reports_cubit.dart';

sealed class ReportsState extends Equatable {
  const ReportsState();

  @override
  List<Object> get props => [];
}

final class ReportsLoading extends ReportsState {}

final class ReportsError extends ReportsState {
  final Exception error;

  const ReportsError({required this.error});

  @override
  // TODO: implement props
  List<Object> get props => [error];
}

final class ReportsNotFound extends ReportsState {
  const ReportsNotFound();

  @override
  List<Object> get props => [];
}

final class ReportsInitial extends ReportsState {
  final List<ReportData> reports;
  final bool newReports;
  const ReportsInitial({required this.reports, this.newReports = false});

  @override
  List<Object> get props => [reports, newReports];
}

final class ReportsExploreTest extends ReportsState {
  final Test test;

  const ReportsExploreTest({required this.test});
  @override
  List<Object> get props => [test];
}

final class ReportsExploreBank extends ReportsState {
  final Bank bank;

  const ReportsExploreBank({required this.bank});
  @override
  List<Object> get props => [bank];
}
