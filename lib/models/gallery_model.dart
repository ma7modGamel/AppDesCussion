import 'dart:convert';
import 'package:discussion/tools/app_constants.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Gallery {
  final String image;
  int id;

  Gallery(this.image);
}

// ignore: missing_return
Future<List<Gallery>> getGallery() async {
  final prefs = await SharedPreferences.getInstance();
  final key = 'token';
  String value = prefs.get(key) ?? 0;
  final requestURL = serverUrl + '/me/images';
  final response = await http.get(Uri.parse(requestURL), headers: {
    "Authorization": "Bearer $value",
    "Accept": "application/json",
    "Accept-Language": Get.locale.countryCode
  });

  if (response.statusCode == 200) {
    var jsonResponse = json.decode(response.body);
    List<Gallery> gallery = [];

    print("images###");
    print(jsonResponse["data"]);
    print("images###");
    for (var image in jsonResponse["data"]) {

      Gallery newGallery = Gallery(image["image"]);
      newGallery.id=image["id"];
      gallery.add(newGallery);
      print(newGallery);
    }

    return gallery;
  }
}
