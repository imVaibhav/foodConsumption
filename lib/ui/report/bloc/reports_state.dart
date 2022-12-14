part of 'reports_bloc.dart';

@immutable
abstract class ReportsState {}

class ReportsInitial extends ReportsState {}

class ShowReports extends ReportsState {
  UserReport report;
  ShowReports(this.report);
}

class ErrorWhileFetching extends ReportsState {
  String msg;
  ErrorWhileFetching(this.msg);
}

class FetchingReports extends ReportsState {}
