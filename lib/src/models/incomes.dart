import 'dart:convert';

Incomes incomesFromJson(String str) => Incomes.fromJson(json.decode(str));

String incomesToJson(Incomes data) => json.encode(data.toJson());

class Incomes {
  int status;
  String message;
  int count;
  List<Datum> data;

  Incomes({
    required this.status,
    required this.message,
    required this.count,
    required this.data,
  });

  factory Incomes.fromJson(Map<String, dynamic> json) => Incomes(
    status: json["status"],
    message: json["message"],
    count: json["count"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "count": count,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  String identification;
  String fullName;
  int userId;
  int collaboratorId;
  int incomeExitId;
  DateTime dateTimeIn;

  Datum({
    required this.identification,
    required this.fullName,
    required this.userId,
    required this.collaboratorId,
    required this.incomeExitId,
    required this.dateTimeIn,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    identification: json["identification"],
    fullName: json["full_name"],
    userId: json["user_id"],
    collaboratorId: json["collaborator_id"],
    incomeExitId: json["income_exit_id"],
    dateTimeIn: DateTime.parse(json["date_time_in"]),
  );

  Map<String, dynamic> toJson() => {
    "identification": identification,
    "full_name": fullName,
    "user_id": userId,
    "collaborator_id": collaboratorId,
    "income_exit_id": incomeExitId,
    "date_time_in": dateTimeIn.toIso8601String(),
  };
}
