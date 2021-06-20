import 'package:flutter/foundation.dart';

class PrefrencesProvider with ChangeNotifier {
  // List<Nations> _nations;
  String _name;
  String _image;
  int _id;

  get name {
    return this._name;
  }

  get image {
    return this._image;
  }

  get id {
    return this._id;
  }

  set name(String item) {
    this._name = item;
    notifyListeners();
  }

  set image(String item) {
    this._image = item;
    notifyListeners();
  }

  set id(int item) {
    this._id = item;
    notifyListeners();
  }
}
