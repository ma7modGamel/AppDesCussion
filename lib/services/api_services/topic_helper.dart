import 'dart:convert';
import 'package:discussion/provider/dropdownbuttons_provider.dart';
import 'package:discussion/services/api_services/profile_helper.dart';
import 'package:http/http.dart' as http;
import 'package:discussion/tools/app_constants.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TopicHelper {
  var token;
  var status;
  var msgStatus;
  var info;

  getTopic() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;

    String myUrl = "$serverUrl/topics";
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


  postTopic(int id, String gendre) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;

    String myUrl = "$serverUrl/topics/$id/join-topic";
    final response = await http.post(Uri.parse(myUrl),
        headers: {
          'Accept': 'application/json',
          'Accept-Language': Get.locale.languageCode,
          'Authorization': 'Bearer $value',
          "content-type": "application/json"
        },
        body: json.encode({
          "preferences": [
            {"preference_id": 1, "value": gendre}
          ]
        }));
    info = json.decode(response.body);
    status = response.body.contains('errors');
    print(info);
    print('Response status : ${response.statusCode}');
    print('Response body : ${response.body}');
  }

  getAccessTokn(int id, String gendre,nation) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;

    if(gendre == 'ذكر'){
      gendre="1";
    }else if(gendre == 'انثى'){
      gendre="2";
    }else{
      gendre="3";
    }
    print("#####$nation");
    ProfileHelper profileHelper = ProfileHelper();
    await profileHelper.getProfile();
    int userId=profileHelper.info["data"]["user"]["id"];
    String myUrl = "$serverUrl/agora/token/channel?topic=$id&gender=$gendre&user_id=$userId";
    if(nation != null && nation.toString().isNotEmpty){
      myUrl=myUrl+"&country=${nation}";
    }
    print(myUrl);
    final response = await http.post(Uri.parse(myUrl),
        headers: {
          'Accept': 'application/json',
          'Accept-Language': Get.locale.languageCode,
          'Authorization': 'Bearer $value',
        },
        );
    var info = json.decode(response.body);
    var status = response.body.contains('errors');
    print(info);
    print('Response status : ${response.statusCode}');
    print('Response body : ${response.body}');
    return info;
  }

  static updateFcmToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;

    print(token);

    String myUrl = "$serverUrl/update-fcm-token?fcm_token=$token";
    print(myUrl);
    final response = await http.post(Uri.parse(myUrl),
      headers: {
        'Accept': 'application/json',
        'Accept-Language': Get.locale.languageCode,
        'Authorization': 'Bearer $value',
      },
    );
    var info = response.body=="success"?true:false;
    var status = response.body.contains('errors');
    print(info);
    print('Response status : ${response.statusCode}');
    print('Response body : ${response.body}');
    return info;
  }

  static Future<List> search(String keyValue) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;

    print(keyValue);

    String myUrl = "$serverUrl/user-search?user_name=$keyValue";
    print(myUrl);
    final response = await http.post(Uri.parse(myUrl),
      headers: {
        'Accept': 'application/json',
        'Accept-Language': Get.locale.languageCode,
        'Authorization': 'Bearer $value',
      },
    );
    var info = json.decode(response.body);
    var status = response.body.contains('errors');
    print(info);
    print('Response status : ${response.statusCode}');
    print('Response body : ${response.body}');
    if(info != null && info['data'] != null){
      return info['data'];
    }
    return [];
  }

  static decreamentTopic(String topic) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;

    print(topic);

    String myUrl = "$serverUrl/user-quit-topic?topic_id=$topic";
    print(myUrl);
    final response = await http.post(Uri.parse(myUrl),
      headers: {
        'Accept': 'application/json',
        'Accept-Language': Get.locale.languageCode,
        'Authorization': 'Bearer $value',
      },
    );
    //var info = json.decode(response.body);
    var status = response.body.contains('errors');
    //print(info);
    print('Response status : ${response.statusCode}');
    print('Response body : ${response.body}');
    /*if(info != null && info['data'] != null){
      return info['data'];
    }*/
    return [];
  }

  static call(String user2,topic) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;


    ProfileHelper profileHelper = ProfileHelper();
    await profileHelper.getProfile();
    int userId=profileHelper.info["data"]["user"]["id"];
    String myUrl = "$serverUrl/agora/open/session?topic_id=$topic&user1_id=$userId&user2_id=$user2";

    print(myUrl);
    final response = await http.post(Uri.parse(myUrl),
      headers: {
        'Accept': 'application/json',
        'Accept-Language': Get.locale.languageCode,
        'Authorization': 'Bearer $value',
      },
    );
    var info = json.decode(response.body);
    var status = response.body.contains('errors');
    print(info);
    print('Response status : ${response.statusCode}');
    print('Response body : ${response.body}');
    return info;
  }
}
