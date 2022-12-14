import 'package:bloc/bloc.dart';
import 'package:canteen/model/user_reports_model.dart';
import 'package:canteen/ui/report/bloc/reports_repo.dart';
import 'package:meta/meta.dart';

part 'reports_event.dart';
part 'reports_state.dart';

class ReportsBloc extends Bloc<ReportsEvent, ReportsState> {
  final ReportsRepo _repo;
  ReportsBloc(this._repo) : super(ReportsInitial()) {
    on<ReportsEvent>((event, emit) async {
      if (event is FetchReportsEvent) {
        emit(FetchingReports());
        var temp = await _repo.getReports();
        if (temp is UserReport) {
          emit(ShowReports(temp));
        } else
          emit(ErrorWhileFetching(temp.toString()));
      }
    });
  }
}
