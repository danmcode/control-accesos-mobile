import 'package:access_control/src/configuration/models/configuration_model.dart';
import 'package:access_control/src/constants/constants.dart';
import 'package:access_control/src/custom_widgets/custom_widgets.dart';
import 'package:access_control/src/helpers/helpers.dart';
import 'package:access_control/src/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../themes/app_colors.dart';

class ConfigurationScreen extends StatefulWidget {
  const ConfigurationScreen({super.key});

  @override
  State<ConfigurationScreen> createState() => _ConfigurationScreenState();
}

class _ConfigurationScreenState extends State<ConfigurationScreen> {
  @override
  Widget build(BuildContext context) {
    final configurationFormProvider =
        Provider.of<ConfigurationFormProvider>(context);

    ConfigurationModel configuration = ConfigurationModel(
      id: 0,
      serverDirection: '',
    );

    if (configurationFormProvider.configurations.isNotEmpty) {
      configuration = configurationFormProvider.configurations[0];
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          PCustomContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _pageTitle(title: AppSpanishLabels.configuration),
                const SizedBox(height: 14),
                _configurationForm(
                  formProvider: configurationFormProvider,
                  initialValue: configuration.serverDirection!,
                ),
              ],
            ),
          ),
          (configuration.id != 0)
              ? PCustomContainer(
                  child: ElevatedButton(
                    onPressed: () async {
                      if (!configurationFormProvider.isValidForm()) return;
                      FocusScope.of(context).unfocus();
                      _modalConfigurationLoading(context: context).show();

                      final newConfiguration =
                          await configurationFormProvider.updateConfiguration(
                        id: configuration.id!,
                        serverDirection:
                            configurationFormProvider.serverDirection!,
                      );

                      if (newConfiguration.id != null) {
                        if (!context.mounted) return;
                        _modalConfigurationLoading(context: context).hide();

                        _modalConfigurationSuccess(
                          context: context,
                          configuration: newConfiguration,
                        ).show();
                      } else {
                        if (!context.mounted) return;
                        _modalConfigurationLoading(context: context).hide();
                      }
                    },
                    child: const Text(AppSpanishLabels.updateButton),
                  ),
                )
              : PCustomContainer(
                  child: ElevatedButton(
                    onPressed: () async {
                      if (!configurationFormProvider.isValidForm()) return;

                      _modalConfigurationLoading(context: context).show();

                      final newConfiguration =
                          await configurationFormProvider.newConfiguration(
                              serverDirection:
                                  configurationFormProvider.serverDirection!);

                      if (newConfiguration.id != null) {
                        if (!context.mounted) return;
                        _modalConfigurationLoading(context: context).hide();

                        _modalConfigurationSuccess(
                          context: context,
                          configuration: newConfiguration,
                        ).show();
                      } else {
                        if (!context.mounted) return;
                        _modalConfigurationLoading(context: context).hide();
                      }
                    },
                    child: const Text(AppSpanishLabels.saveButton),
                  ),
                ),
        ],
      ),
    );
  }
}

_pageTitle({required String title}) => Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );

_configurationForm({
  required ConfigurationFormProvider formProvider,
  String initialValue = '',
}) {
  return Form(
    key: formProvider.formKey,
    child: Column(
      children: [
        PTextFormField(
          hintText: AppSpanishLabels.serverDirectionEx,
          labelText: AppSpanishLabels.serverDirection,
          prefixIcon: Icons.desktop_windows_outlined,
          initialValue: initialValue,
          isPasswordField: false,
          validator: (value) => InputValidations.validateServerDirection(value),
          keyboardType: TextInputType.url,
          onchange: (value) => formProvider.serverDirection = value!.trim(),
        ),
      ],
    ),
  );
}

_modalConfigurationLoading({required BuildContext context}) {
  return PCustomModalBottom(
    context: context,
    icon: Icons.save,
    modalTitle: AppSpanishLabels.savingServerAddress,
    isLoader: true,
    modalBody: const Column(
      children: [
        Text(AppSpanishLabels.pleaseWait),
      ],
    ),
  );
}

_modalConfigurationSuccess({
  required BuildContext context,
  required ConfigurationModel configuration,
}) {
  return PCustomModalBottom(
    enableDrag: true,
    context: context,
    icon: Icons.check,
    color: AppColors.successColor,
    modalTitle: AppSpanishLabels.saveServerAddressSuccess,
    modalBody: PCustomContainer(
        height: 120,
        child: ListTile(
          title: Text("${configuration.id}: ${configuration.serverDirection}"),
        )),
    actionsWidget: PCustomContainer(
      child: ElevatedButton(
        onPressed: () => Navigator.pop(context),
        child: const Text(AppSpanishLabels.goBack),
      ),
    ),
  );
}
