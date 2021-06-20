import 'dart:convert';
import 'package:discussion/tools/app_constants.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Nations {
  final int id;
  final String name;

  Nations(this.id, this.name);
}

// ignore: missing_return
Future<List<Nations>> getNations() async {
  print("getNations");
  final requestURL = serverUrl + '/countries';
  final response = await http.get(Uri.parse(requestURL),
      headers: {"Accept-Language": Get.locale.languageCode});

  if (response.statusCode == 200) {
    var jsonResponse = json.decode(response.body);
    List<Nations> nations = [];

    for (var nation in jsonResponse["data"]) {
      Nations newNations = Nations(nation["id"], nation["name"]);
      nations.add(newNations);
      print(newNations);
    }

    return nations;
  }
}
