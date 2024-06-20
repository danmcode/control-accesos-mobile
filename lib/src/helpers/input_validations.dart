import 'package:access_control/src/constants/app_spanish_labels.dart';

class InputValidations {
  static validateServerDirection(value) {
    final validAddress = RegExp(
        r'^(?:(?:[0-9]{1,3}\.){3}[0-9]{1,3}:[0-9]{1,5}|[a-zA-Z0-9.-]+:[0-9]{1,5}|[a-zA-Z0-9.-]+)$');

    if (value.toString().trim().isEmpty) {
      return AppSpanishLabels.fieldCantBeEmpty;
    }

    if (!validAddress.hasMatch(value!)) {
      return value + ": " + AppSpanishLabels.serverAddressInvalid;
    }
  }
}