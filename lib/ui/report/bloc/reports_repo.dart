import 'package:canteen/data/api/api_provider.dart';
import 'package:canteen/data/dummy/reports_dummy.dart';
import 'package:canteen/model/user_reports_model.dart';

class ReportsRepo {
  final ApiProvider _apiProvider = ApiProvider();

  Future<dynamic> getReports() async {
    try {
      var response = await _apiProvider.fetchReports({"month": 11});
      if (response != null && response.statusCode == 200) {
        var parsed = userReportFromJson(response.body);
        return parsed;
      }
    } catch (e) {
      return e.toString();
    }
  }

  double calculatTotalFineAmt(List<Report> list) {
    return list.fold(0.0, (previousValue, element) {
      if (element.optIns != null) {
        if (element?.optIns?.breakfast == 'Pending') previousValue += 100;
        if (element?.optIns?.lunch == 'Pending') previousValue += 100;
        if (element?.optIns?.dinner == 'Pending') previousValue += 100;
      }
      return previousValue;
    });
  }

  double calculateOneDay(OptInsClass status) {
    double totalFine = 0.0;
    if (status != null) {
      if (status?.breakfast == 'Pending') totalFine += 100;
      if (status?.lunch == 'Pending') totalFine += 100;
      if (status?.dinner == 'Pending') totalFine += 100;
    }
    return totalFine;
  }
}
