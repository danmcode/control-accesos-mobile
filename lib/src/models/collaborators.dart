import 'dart:convert';

Collaborator collaboratorFromJson(String str) => Collaborator.fromJson(json.decode(str));

String collaboratorToJson(Collaborator data) => json.encode(data.toJson());

class Collaborator {
  int status;
  String message;
  Data data;

  Collaborator({
    required this.status,
    required this.message,
    required this.data,
  });

  factory Collaborator.fromJson(Map<String, dynamic> json) => Collaborator(
    status: json["status"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  User user;
  Income income;

  Data({
    required this.user,
    required this.income,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    user: User.fromJson(json["user"]),
    income: Income.fromJson(json["income"]),
  );

  Map<String, dynamic> toJson() => {
    "user": user.toJson(),
    "income": income.toJson(),
  };
}

class Income {
  DateTime dateTimeIn;
  int collaboratorId;
  int createdBy;
  int registeredInBy;
  String observation;
  int outOfTime;
  DateTime updatedAt;
  DateTime createdAt;
  int id;

  Income({
    required this.dateTimeIn,
    required this.collaboratorId,
    required this.createdBy,
    required this.registeredInBy,
    required this.observation,
    required this.outOfTime,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  factory Income.fromJson(Map<String, dynamic> json) => Income(
    dateTimeIn: DateTime.parse(json["date_time_in"]),
    collaboratorId: json["collaborator_id"],
    createdBy: json["created_by"],
    registeredInBy: json["registered_in_by"],
    observation: json["observation"],
    outOfTime: json["out_of_time"],
    updatedAt: DateTime.parse(json["updated_at"]),
    createdAt: DateTime.parse(json["created_at"]),
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "date_time_in": dateTimeIn.toIso8601String(),
    "collaborator_id": collaboratorId,
    "created_by": createdBy,
    "registered_in_by": registeredInBy,
    "observation": observation,
    "out_of_time": outOfTime,
    "updated_at": updatedAt.toIso8601String(),
    "created_at": createdAt.toIso8601String(),
    "id": id,
  };
}

class User {
  int id;
  String username;
  String identification;
  int identificationType;
  String photoPath;
  String name;
  String lastName;
  int isActive;
  String email;
  int roleId;
  int isColaborator;

  User({
    required this.id,
    required this.username,
    required this.identification,
    required this.identificationType,
    required this.photoPath,
    required this.name,
    required this.lastName,
    required this.isActive,
    required this.email,
    required this.roleId,
    required this.isColaborator,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    username: json["username"],
    identification: json["identification"],
    identificationType: json["identification_type"],
    photoPath: json["photo_path"],
    name: json["name"],
    lastName: json["last_name"],
    isActive: json["is_active"],
    email: json["email"],
    roleId: json["role_id"],
    isColaborator: json["is_colaborator"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "identification": identification,
    "identification_type": identificationType,
    "photo_path": photoPath,
    "name": name,
    "last_name": lastName,
    "is_active": isActive,
    "email": email,
    "role_id": roleId,
    "is_colaborator": isColaborator,
  };
}

class Collaborators {
  int id;
  int areaManager;
  int userId;
  int companyId;
  int areaId;
  int jobTitleId;
  int locationId;
  DateTime createdAt;
  DateTime updatedAt;
  IdentificationTypes company;
  IdentificationTypes area;
  IdentificationTypes jobTitle;
  IdentificationTypes location;

  Collaborators({
    required this.id,
    required this.areaManager,
    required this.userId,
    required this.companyId,
    required this.areaId,
    required this.jobTitleId,
    required this.locationId,
    required this.createdAt,
    required this.updatedAt,
    required this.company,
    required this.area,
    required this.jobTitle,
    required this.location,
  });

  factory Collaborators.fromJson(Map<String, dynamic> json) => Collaborators(
    id: json["id"],
    areaManager: json["area_manager"],
    userId: json["user_id"],
    companyId: json["company_id"],
    areaId: json["area_id"],
    jobTitleId: json["job_title_id"],
    locationId: json["location_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    company: IdentificationTypes.fromJson(json["company"]),
    area: IdentificationTypes.fromJson(json["area"]),
    jobTitle: IdentificationTypes.fromJson(json["job_title"]),
    location: IdentificationTypes.fromJson(json["location"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "area_manager": areaManager,
    "user_id": userId,
    "company_id": companyId,
    "area_id": areaId,
    "job_title_id": jobTitleId,
    "location_id": locationId,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "company": company.toJson(),
    "area": area.toJson(),
    "job_title": jobTitle.toJson(),
    "location": location.toJson(),
  };
}

class IdentificationTypes {
  int id;
  String name;
  int? companyId;
  int isActive;
  int? createdBy;
  dynamic updatedBy;
  DateTime createdAt;
  DateTime updatedAt;
  String? nit;
  int? areaId;
  String? initials;

  IdentificationTypes({
    required this.id,
    required this.name,
    this.companyId,
    required this.isActive,
    required this.createdBy,
    required this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
    this.nit,
    this.areaId,
    this.initials,
  });

  factory IdentificationTypes.fromJson(Map<String, dynamic> json) => IdentificationTypes(
    id: json["id"],
    name: json["name"],
    companyId: json["company_id"],
    isActive: json["is_active"],
    createdBy: json["created_by"],
    updatedBy: json["updated_by"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    nit: json["nit"],
    areaId: json["area_id"],
    initials: json["initials"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "company_id": companyId,
    "is_active": isActive,
    "created_by": createdBy,
    "updated_by": updatedBy,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "nit": nit,
    "area_id": areaId,
    "initials": initials,
  };
}