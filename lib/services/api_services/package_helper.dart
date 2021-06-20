import 'dart:convert';
import 'package:discussion/models/subscription.dart';
import 'package:http/http.dart' as http;
import 'package:discussion/tools/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PackageHelper {
  var token;
  var status;
  var msgStatus;
  var info;

  getPackages() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;

    String myUrl = "$serverUrl/packages";
    final response = await http.get(
      Uri.parse(myUrl),
      headers: {
        'Accept': 'application/json',
        'Accept-Language': Get.locale.languageCode,
        'Authorization': 'Bearer $value'
      },
    );
    info = json.decode(response.body);
    print('Response status : ${response.statusCode}');
    print('Response body : ${response.body}');
  }

  getPackage(int id) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;

    String myUrl = "$serverUrl/packages/$id";
    final response = await http.get(
      Uri.parse(myUrl),
      headers: {
        'Accept': 'application/json',
        'Accept-Language': Get.locale.languageCode,
        'Authorization': 'Bearer $value'
      },
    );
    info = json.decode(response.body);
    print('Response status : ${response.statusCode}');
    print('Response body : ${response.body}');
  }

  static getSubscriptions() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;

    String myUrl = "$serverUrl/api/v1/subscriptions";
    final response = await http.get(
      Uri.parse(myUrl),
      headers: {
        'Accept-Language': Get.locale.languageCode,
        'Authorization': 'Bearer $value'
      },
    );
    var res = json.decode(response.body);
    print('Response status : ${response.statusCode}');
    print('Response body : ${response.body}');
    return res;
  }

  static subscribe(userId, packageId) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;

    String myUrl = "$serverUrl/subscribe";
    final response = await http.post(Uri.parse(myUrl),
        headers: {
          'Accept-Language': Get.locale.languageCode,
          'Authorization': 'Bearer $value',
        },
        body: {
          "user_id":userId.toString(),
          "package_id":packageId.toString()
        });
    var info = json.decode(response.body);
    var status = response.body.contains('errors');
    print(info);
    print('Response status : ${response.statusCode}');
    print('Response body : ${response.body}');
    return info;
  }

  static getCurrentSub(userId) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;

    String myUrl = "$serverUrl/sub/$userId";
    final response = await http.get(Uri.parse(myUrl),
        headers: {
          'Accept-Language': Get.locale.languageCode,
          'Authorization': 'Bearer $value',
        });
    var info = json.decode(response.body);
    var status = response.body.contains('errors');
    if(info != null && info['subscription'] != null){
      return Subscription.mapToObject(info['subscription']);
    }
    print(info);
    print('Response status : ${response.statusCode}');
    print('Response body : ${response.body}');
    return null;
  }

  static endCall(callId, endTime) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;

    String myUrl = "$serverUrl/endcall";
    final response = await http.post(Uri.parse(myUrl),
        headers: {
          'Accept-Language': Get.locale.languageCode,
          'Authorization': 'Bearer $value',
        },
        body: {
          "call_id":callId.toString(),
          "call_min":endTime.toString()
        });
    var info = json.decode(response.body);
    var status = response.body.contains('errors');
    print(info);
    print('Response status : ${response.statusCode}');
    print('Response body : ${response.body}');
    return info;
  }
}
