import 'package:flutter/foundation.dart';

class LoadProvider with ChangeNotifier {
  bool _load = true;
  var _nations;

  get load {
    return this._load;
  }

  get nations {
    return _nations;
  }

  set load(bool item) {
    this._load = item;
    notifyListeners();
  }

  set nations(var item) {
    this._nations = item;
    notifyListeners();
  }
}
