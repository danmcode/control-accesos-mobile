import 'package:flutter/material.dart';

class IdentificationProvider extends ChangeNotifier{
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String? identification;

  bool isValidForm() => formKey.currentState?.validate() ?? false;

}