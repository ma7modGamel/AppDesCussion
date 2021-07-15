import 'dart:convert';
import 'dart:io';
import 'package:discussion/services/local_services/shared_prefrences.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:discussion/tools/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthHelper {
  var status;
  var token;
  var msgStatus;
  var info;
  var type;
  SharedPrefService databaseHelper = SharedPrefService();

  loginData(String email, String password) async {
    String myUrl = "$serverUrl/login";
    final response = await http.post(Uri.parse(myUrl), headers: {
      'Accept': 'application/json',
      'Accept-Language': Get.locale.languageCode,
    }, body: {
      "email": "$email",
      "password": "$password",
      "device_name": "${Platform.localHostname}"
    });
    info = json.decode(response.body);
    status = info["success"];
    msgStatus = info["message"];
    String token = info["token"];
    if (status == false) {
      print('login status: $status');
    } else {
      print('token: $token');
      print(info["token"]);
      databaseHelper.setValue('token', token);
    }
  }

  registerData(String name, String email, String password, int gendre,
      int country, String phone) async {
    String myUrl = "$serverUrl/register";
    print("##");
    final response = await http.post(Uri.parse(myUrl), headers: {
      'Accept': 'application/json',
      'Accept-Language': Get.locale.languageCode,
    }, body: {
      "name": "$name",
      "email": "$email",
      "password": "$password",
      "gender_id": "$gendre",
      "country_id": "$country",
      "device_name": "${Platform.localHostname}",
    });

    print("##");
    print(info);
    info = json.decode(response.body);
    status = info["success"];
    String token = info["token"];
    print(info);
    if (status == true) {
      print(info["token"]);
      databaseHelper.setValue('token', token);
    } else {
      msgStatus=info['message'];
      print('data : $info');
    }
  }

  logoutData() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;

    String myUrl = "$serverUrl/logout";
    try{
      final response = await http.post(Uri.parse(myUrl), headers: {
        'Accept': 'application/json',
        'Accept-Language': Get.locale.languageCode,
        'Authorization': "Bearer $value"
      }, body: {});
      info = json.decode(response.body);
      status = info["success"];
    }catch(e){

    }
    print(info);
    if (status == true) {
      databaseHelper.setValue("token", "0");
    } else if (info == null || info["message"] == "unauthrized") {
      databaseHelper.setValue("token", "0");
    }
  }

  getNations() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;

    String myUrl = "$serverUrl/countries";
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
}
