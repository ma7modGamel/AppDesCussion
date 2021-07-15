import 'dart:convert';
import 'package:discussion/services/api_services/profile_helper.dart';
import 'package:discussion/tools/app_constants.dart';
import 'package:flutter/foundation.dart';

class NationProvider with ChangeNotifier {
  ProfileHelper profileHelper = ProfileHelper();
  String _name;
  int _id;
  String selectedId;

  NationProvider() {
    profileHelper.getProfile().whenComplete(() {
      _id = profileHelper.info["data"]["user"]["country"]["id"];
    });
  }

  get name {
    return this._name;
  }

  get id {
    return this._id;
  }

  set name(String item) {
    this._name = item;
    notifyListeners();
  }

  set id(int item) {
    this._id = item;
    notifyListeners();
  }
}

class GendreProvider with ChangeNotifier {
  ProfileHelper profileHelper = ProfileHelper();
  String _name;
  String _image;
  int _id;

  GendreProvider() {
    profileHelper.getProfile().whenComplete(() {
      _id = profileHelper.info["data"]["user"]["gender"]["id"];
    });
  }

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

class LanguageProvider with ChangeNotifier {
  List<dynamic> _languageList = jsonDecode('''[
    {
      "name": "عربي",
      "button" : "التالي",
      "image": "$ksa"
    },
    {
      "name": "English",
      "button" : "next",
      "image": "$uk"
    }
  ]''');

  String _name = 'عربي';
  String _button = 'التالي';
  String _image = ksa;

  get languageList {
    return _languageList;
  }

  get name {
    return this._name;
  }

  get button {
    return this._button;
  }

  get image {
    return this._image;
  }

  set name(String item) {
    this._name = item;
    notifyListeners();
  }

  set image(String item) {
    this._image = item;
    notifyListeners();
  }

  set button(String item) {
    this._button = item;
    notifyListeners();
  }
}
