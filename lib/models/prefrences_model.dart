import 'dart:convert';
import 'package:discussion/tools/app_constants.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Prefrences {
  final int id;
  final String name;
  final String image;

  Prefrences(this.id, this.name, this.image);
}

// ignore: missing_return
Future<List<Prefrences>> getPrefrences() async {
  final requestURL = serverUrl + '/preferences';
  final response = await http.get(Uri.parse(requestURL),
      headers: {"Accept-Language": Get.locale.languageCode});

  if (response.statusCode == 200) {
    var jsonResponse = json.decode(response.body);
    List<Prefrences> prefrencess = [];

    for (var prefrences in jsonResponse["data"][0]["values"]) {
      Prefrences newPrefrencess =
          Prefrences(prefrences["id"], prefrences["name"], prefrences["image"]);
      prefrencess.add(newPrefrencess);
      print(newPrefrencess);
    }

    return prefrencess;
  }
}
