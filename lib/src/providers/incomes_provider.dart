import 'package:access_control/src/home/repository/fetch_incomes.dart';
import 'package:access_control/src/models/incomes.dart';
import 'package:flutter/material.dart';

class IncomesProvider extends ChangeNotifier {
  int _numberOfCollaborators = 0;
  List<Datum> _incomesList = [];

  int get numberOfCollaborators => _numberOfCollaborators;
  List<Datum> get incomesList => _incomesList;

  set numberOfCollaborators(int numberOfCollaborators) {
    _numberOfCollaborators = numberOfCollaborators;
    notifyListeners();
  }

  set incomesList(List<Datum> incomesList) {
    _incomesList = incomesList;
    notifyListeners();
  }

  void loadIncomes(BuildContext context) async {
    await FetchIncomes.fetchData(context);
    notifyListeners();
  }
}
