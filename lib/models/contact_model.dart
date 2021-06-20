import 'dart:convert';
import 'package:discussion/tools/app_constants.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Contact {
  final String content;
  // final List<String> phones;
  // final String facebook;
  // final String instagram;
  // final String twitter;
  // final String snapchat;
  // final String whatsapp;
  // final String website;

  Contact(this.content);
  // , this.phones, this.facebook, this.instagram,
  // this.twitter, this.snapchat, this.whatsapp, this.website);
}

// ignore: missing_return
Future<List<Contact>> getContact() async {
  final prefs = await SharedPreferences.getInstance();
  final key = 'token';
  String value = prefs.get(key) ?? 0;
  final requestURL = serverUrl + '/contact-us';
  final response = await http.get(Uri.parse(requestURL), headers: {
    "Authorization": "Bearer $value",
    "Accept": "application/json",
    "Accept-Language": Get.locale.countryCode
  });

  if (response.statusCode == 200) {
    var jsonResponse = json.decode(response.body);
    List<Contact> contacts;
    print(response.body.runtimeType);

    for (var contact in jsonResponse) {
      Contact newContact = Contact(contact["content"]);
      // contact["phones"],
      // contact["facebook"],
      // contact["instagram"],
      // contact["twitter"],
      // contact["snapchat"],
      // contact["whatsapp"],
      // contact["website"]);
      contacts.add(newContact);
      print(newContact);
    }

    return contacts;
  }
}
