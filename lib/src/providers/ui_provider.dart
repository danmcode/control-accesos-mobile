import 'package:flutter/material.dart';

class UiProvider extends ChangeNotifier {
  int _selectedMenuOpt = 0;
  int _numberOfCollaborators = 0;
  bool _showModalBottomSheet = true;

  int get selectedMenuOpt => _selectedMenuOpt;
  int get numberOfCollaborators => _numberOfCollaborators;
  bool get showModalBottomSheet => _showModalBottomSheet;

  set numberOfCollaborators(int numberOfCollaborators){
    _numberOfCollaborators = numberOfCollaborators;
    notifyListeners();
  }

  set selectedMenuOpt(int selectedMenuOpt){
    _selectedMenuOpt = selectedMenuOpt;
    notifyListeners();
  }

  set hideShowModalBottomSheet(bool showModalBottomSheet){
    _showModalBottomSheet = showModalBottomSheet;
    notifyListeners();
  }

}
