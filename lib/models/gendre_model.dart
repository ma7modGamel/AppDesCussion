import 'dart:convert';
import 'package:discussion/tools/app_constants.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Gendre {
  final int id;
  final String name;
  final String image;

  Gendre(this.id, this.name, this.image);
}

// ignore: missing_return
Future<List<Gendre>> getGendre() async {
  print("getGendre");
  final requestURL = serverUrl + '/genders';
  final response = await http.get(Uri.parse(requestURL),
      headers: {"Accept-Language": Get.locale.languageCode});

  if (response.statusCode == 200) {
    var jsonResponse = json.decode(response.body);
    List<Gendre> gendres = [];

    for (var gendre in jsonResponse["data"]) {
      print("########m");
      Gendre newGendres = Gendre(gendre["id"], gendre["name"], gendre["image"]);
      gendres.add(newGendres);
      print(newGendres);
    }

    return gendres;
  }
}
