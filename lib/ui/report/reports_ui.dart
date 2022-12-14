import 'package:canteen/ui/report/bloc/reports_bloc.dart';
import 'package:canteen/ui/report/bloc/reports_repo.dart';
import 'package:flutter_bloc/src/bloc_provider.dart';
import 'package:flutter_bloc/src/bloc_consumer.dart';
import 'package:flutter/material.dart';

import '../../model/user_reports_model.dart';

class Reports extends StatefulWidget {
  const Reports({Key key}) : super(key: key);

  @override
  State<Reports> createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {
  ReportsRepo _repo;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _repo = ReportsRepo();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReportsBloc(ReportsRepo())..add(FetchReportsEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Reports'),
        ),
        body: BlocConsumer<ReportsBloc, ReportsState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is FetchingReports) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is ErrorWhileFetching) {
              return Center(
                child: Text("state.msg"),
              );
            } else if (state is ShowReports) {
              var totalFinedAmt =
                  _repo.calculatTotalFineAmt(state.report.reports);
              return Padding(
                padding: const EdgeInsets.only(top: 16, right: 16, left: 16),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.blueGrey),
                          borderRadius: BorderRadius.circular(16)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              'Report for ${state.report.user.fName} ${state.report.user.lName}'),
                          Text('Total fine: $totalFinedAmt',
                              style: TextStyle(
                                color: totalFinedAmt > 0
                                    ? Colors.red
                                    : Colors.black,
                              ))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Expanded(
                      child: ListView.separated(
                        itemCount: state.report.reports.length,
                        itemBuilder: (context, index) {
                          return _buildDayCard(state.report.reports[index]);
                        },
                        separatorBuilder: (context, index) => Divider(
                          thickness: 1,
                          color: Colors.grey,
                        ),
                      ),
                    )
                  ],
                ),
              );
            } else {
              return Center(
                child: Text('Somthing went wrong!'),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildDayCard(Report dayReport) {
    var finedAmt = _repo.calculateOneDay(dayReport.optIns);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Date ${dayReport.date}"),
              Text('Fined Amt: ${_repo.calculateOneDay(dayReport.optIns)}',
                  style: TextStyle(
                    color: finedAmt > 0 ? Colors.red : Colors.grey,
                  ))
            ],
          ),
          SizedBox(
            height: 4,
          ),
          Wrap(
            spacing: 10,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('BreakFast: '),
                  Text(dayReport?.optIns?.breakfast ?? 'NA'),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Lunch: '),
                  Text(dayReport?.optIns?.lunch ?? 'NA'),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Dinner: '),
                  Text(dayReport?.optIns?.dinner ?? 'NA'),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
