import 'package:flutter/foundation.dart';

class BottomNavigationBarProvider with ChangeNotifier {
  int _selectedIndex = 0;

  get selectedIndex => _selectedIndex;

  set selectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
}
