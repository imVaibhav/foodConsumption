// To parse this JSON data, do
//
//     final userReport = userReportFromJson(jsonString);

import 'dart:convert';

UserReport userReportFromJson(String str) =>
    UserReport.fromJson(json.decode(str));

String userReportToJson(UserReport data) => json.encode(data.toJson());

class UserReport {
  UserReport({
    this.user,
    this.reports,
  });

  User user;
  List<Report> reports;

  factory UserReport.fromJson(Map<String, dynamic> json) => UserReport(
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        reports: json["reports"] == null
            ? null
            : List<Report>.from(json["reports"].map((x) => Report.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "user": user == null ? null : user.toJson(),
        "reports": reports == null
            ? null
            : List<dynamic>.from(reports.map((x) => x.toJson())),
      };
}

class Report {
  Report({
    this.date,
    this.optIns,
  });

  String date;
  OptInsClass optIns;

  factory Report.fromJson(Map<String, dynamic> json) => Report(
        date: json["date"] == null ? null : json["date"],
        optIns: json["opt_ins"] is Map
            ? OptInsClass.fromJson(json["opt_ins"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "date": date == null ? null : date,
        "opt_ins": optIns,
      };
}

class OptInsClass {
  OptInsClass({
    this.breakfast,
    this.lunch,
    this.dinner,
  });

  String breakfast;
  String lunch;
  String dinner;

  factory OptInsClass.fromJson(Map<String, dynamic> json) => OptInsClass(
        breakfast: json["breakfast"] == null ? null : json["breakfast"],
        lunch: json["lunch"] == null ? null : json["lunch"],
        dinner: json["dinner"] == null ? null : json["dinner"],
      );

  Map<String, dynamic> toJson() => {
        "breakfast": breakfast == null ? null : breakfast,
        "lunch": lunch == null ? null : lunch,
        "dinner": dinner == null ? null : dinner,
      };
}

class User {
  User({
    this.id,
    this.fName,
    this.lName,
    this.phone,
    this.email,
    this.createdAt,
    this.updatedAt,
    this.status,
    this.orderCount,
    this.empId,
    this.departmentId,
    this.isVeg,
    this.isSatOpted,
  });

  int id;
  String fName;
  String lName;
  String phone;
  String email;
  DateTime createdAt;
  DateTime updatedAt;
  int status;
  int orderCount;
  String empId;
  int departmentId;
  int isVeg;
  int isSatOpted;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"] == null ? null : json["id"],
        fName: json["f_name"] == null ? null : json["f_name"],
        lName: json["l_name"] == null ? null : json["l_name"],
        phone: json["phone"] == null ? null : json["phone"],
        email: json["email"] == null ? null : json["email"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        status: json["status"] == null ? null : json["status"],
        orderCount: json["order_count"] == null ? null : json["order_count"],
        empId: json["emp_id"] == null ? null : json["emp_id"],
        departmentId:
            json["department_id"] == null ? null : json["department_id"],
        isVeg: json["is_veg"] == null ? null : json["is_veg"],
        isSatOpted: json["is_sat_opted"] == null ? null : json["is_sat_opted"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "f_name": fName == null ? null : fName,
        "l_name": lName == null ? null : lName,
        "phone": phone == null ? null : phone,
        "email": email == null ? null : email,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "status": status == null ? null : status,
        "order_count": orderCount == null ? null : orderCount,
        "emp_id": empId == null ? null : empId,
        "department_id": departmentId == null ? null : departmentId,
        "is_veg": isVeg == null ? null : isVeg,
        "is_sat_opted": isSatOpted == null ? null : isSatOpted,
      };
}
