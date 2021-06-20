import 'dart:convert';
import 'package:discussion/services/local_services/shared_prefrences.dart';
import 'package:discussion/tools/app_constants.dart';
import 'package:http/http.dart' as http;

class Package {
  final int id;
  final String name;
  final String price;
  final String currency;
  final List<String> features;

  Package(this.id, this.name, this.price, this.currency, this.features);
}

// ignore: missing_return
Future<List<Package>> getPackage(int id) async {
  SharedPrefService databaseHelper = SharedPrefService();
  String language;
  databaseHelper
      .getValue("language")
      .whenComplete(() => language = databaseHelper.value);

  final requestURL = serverUrl + '/packages/$id';
  final response = await http
      .get(Uri.parse(requestURL), headers: {"Accept-Language": language});

  if (response.statusCode == 200) {
    var jsonResponse = json.decode(response.body);
    List<Package> package = [];

    for (var pack in jsonResponse["data"]) {
      Package newPackage = Package(pack["id"], pack["name"],
          pack["price"], pack["currency"], pack["features"]);
      package.add(newPackage);
      print(newPackage);
    }

    return package;
  }
}
