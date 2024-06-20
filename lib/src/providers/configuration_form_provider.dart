import 'package:access_control/src/configuration/models/configuration_model.dart';
import 'package:access_control/src/providers/db_configuration_provider.dart';
import 'package:flutter/material.dart';

class ConfigurationFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  List<ConfigurationModel> configurations = [];

  String? serverDirection = '';

  bool isValidForm() => formKey.currentState?.validate() ?? false;

  Future<ConfigurationModel> newConfiguration({
    required String serverDirection,
  }) async {
    final newConfigurationModel = ConfigurationModel(
      serverDirection: serverDirection,
    );
    final id = await DBConfigurationProvider.db
        .newConfiguration(newConfigurationModel);

    newConfigurationModel.id = id;
    configurations.add(newConfigurationModel);
    notifyListeners();

    return newConfigurationModel;
  }

  Future<ConfigurationModel> updateConfiguration({
    required int id,
    required String serverDirection,
  }) async {
    configurations.clear();
    final newConfigurationModel = ConfigurationModel(
      id: id,
      serverDirection: serverDirection,
    );

    final idUpdated = await DBConfigurationProvider.db
        .updateConfiguration(newConfigurationModel);

    newConfigurationModel.id = idUpdated;
    configurations.add(newConfigurationModel);
    notifyListeners();

    return newConfigurationModel;
  }

  loadConfiguration() async {
    final configurations = await DBConfigurationProvider.db.getAllConfigurations();
    this.configurations = [...configurations!];
    notifyListeners();
  }

  deleteAll() async {
    await DBConfigurationProvider.db.deleteAllConfigurations();
    configurations = [];
    notifyListeners();
  }
}
