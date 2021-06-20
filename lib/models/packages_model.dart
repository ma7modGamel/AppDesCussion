import 'dart:convert';
import 'package:discussion/services/local_services/shared_prefrences.dart';
import 'package:discussion/tools/app_constants.dart';
import 'package:http/http.dart' as http;

class Packages {
  final int id;
  final String name;
  final String price;
  final String currency;

  Packages(this.id, this.name, this.price, this.currency);
}

// ignore: missing_return
Future<List<Packages>> getPackages() async {
  SharedPrefService databaseHelper = SharedPrefService();
  String language;
  databaseHelper
      .getValue("language")
      .whenComplete(() => language = databaseHelper.value);

  final requestURL = serverUrl + '/packages';
  final response = await http
      .get(Uri.parse(requestURL), headers: {"Accept-Language": language});

  if (response.statusCode == 200) {
    var jsonResponse = json.decode(response.body);
    List<Packages> packages = [];

    for (var package in jsonResponse["data"]) {
      Packages newPackages = Packages(package["id"], package["name"],
          package["price"], package["currency"]);
      packages.add(newPackages);
      print(newPackages);
    }

    return packages;
  }
}
