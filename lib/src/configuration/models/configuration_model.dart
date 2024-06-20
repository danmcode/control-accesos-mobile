import 'dart:convert';

ConfigurationModel configurationModelFromJson(String str) =>
    ConfigurationModel.fromJson(json.decode(str));

String configurationModelToJson(ConfigurationModel data) =>
    json.encode(data.toJson());

class ConfigurationModel {
  int? id;
  String? serverDirection;

  ConfigurationModel({
    this.id,
    required this.serverDirection,
  });

  factory ConfigurationModel.fromJson(Map<String, dynamic> json) =>
      ConfigurationModel(
        id: json["id"],
        serverDirection: json["serverDirection"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "serverDirection": serverDirection,
      };
}
