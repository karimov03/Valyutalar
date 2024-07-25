import 'package:flutter/material.dart';

class SelectedChipProvider with ChangeNotifier {
  int _selectedChipIndex = 0;

  int get selectedChipIndex => _selectedChipIndex;

  void selectChip(int index) {
    _selectedChipIndex = index;
    notifyListeners();
  }
}
