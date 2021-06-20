import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:discussion/services/local_services/shared_prefrences.dart';
import 'package:discussion/tools/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

class ProfileHelper {
  var token;
  var status;
  var msgStatus;
  var info;
  SharedPrefService databaseHelper = SharedPrefService();

  // getProfile() async {
  // databaseHelper.getValue("token").whenComplete(() {
  // token = databaseHelper.value;
  // print('profile: $token');
  // getUser(token);
  // });
  // }

  getProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;
    print("#######yyyyy");

    String myUrl = "$serverUrl/me";
    final response = await http.get(
      Uri.parse(myUrl),
      headers: {
        'Accept': 'application/json',
        'Accept-Language': Get.locale.languageCode,
        'Authorization': 'Bearer $value'
      },
    );
    info = json.decode(response.body);
    status = info["success"];
    print('Response status : ${response.statusCode}');
    print('Response body : ${response.body}');
  }

  getContact() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;

    String myUrl = "$serverUrl/contact-us";
    final response = await http.get(
      Uri.parse(myUrl),
      headers: {
        'Accept': 'application/json',
        'Accept-Language': Get.locale.languageCode,
        'Authorization': 'Bearer $value'
      },
    );
    info = json.decode(response.body);
    status = info["success"];
    print('Response status : ${response.statusCode}');
    print('Response body : ${response.body}');
  }

  getPolicy() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;

    String myUrl = "$serverUrl/terms-conditions";
    final response = await http.get(
      Uri.parse(myUrl),
      headers: {
        'Accept': 'application/json',
        'Accept-Language': Get.locale.languageCode,
        'Authorization': 'Bearer $value'
      },
    );
    info = json.decode(response.body);
    status = info["success"];
    print('Response status : ${response.statusCode}');
    print('Response body : ${response.body}');
  }

  editProfile(int id, String name, int country, int gendre, String bio,
      File image) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    String value = prefs.get(key) ?? 0;
    final key1 = 'user';
    String user = prefs.get(key1) ?? 0;
    Map<String, String> headers = {
      "Authorization": "Bearer $value",
      "Accept": "application/json",
      "Accept-Language": Get.locale.countryCode
    };
    String myUrl = "$serverUrl/user/$user/update";
    final imageUpLoadRequest = http.MultipartRequest('POST', Uri.parse(myUrl));
    if (image != null) {
      final mimeTypeData =
          lookupMimeType(image.path, headerBytes: [0xff, 0xD8]).split("/");
      final file = await http.MultipartFile.fromPath("image", image.path,
          contentType: MediaType(mimeTypeData[0], mimeTypeData[1]));
      imageUpLoadRequest.files.add(file);
    }
    imageUpLoadRequest.headers['Accept'] = 'application/json';
    imageUpLoadRequest.headers['Content-Type'] = 'application/json';
    imageUpLoadRequest.headers['Accept-Language'] = Get.locale.countryCode;
    imageUpLoadRequest.headers.addAll(headers);
    imageUpLoadRequest.fields["name"] = name;
    imageUpLoadRequest.fields["country_id"] = country.toString();
    imageUpLoadRequest.fields["gender_id"] = gendre.toString();
    imageUpLoadRequest.fields["bio"] = bio;
    // imageUpLoadRequest.fields["image_id"] = imageId.toString();

    try {
      final streamResponse = await imageUpLoadRequest.send();
      final response = await http.Response.fromStream(streamResponse);

      if (response.statusCode != 200) {
        print(response.body);
        msgStatus = json.decode(response.body)["message"];
        // print(user);
        return null;
      }
      final Map<String, dynamic> responseData = json.decode(response.body);
      // _resetState();
      msgStatus = responseData["message"];
      // print(file);
      print(responseData);

      return responseData;
    } catch (e) {
      print(e);
      // print(file);
      return null;
    }
  }

  addImage(File image) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    String value = prefs.get(key) ?? 0;
    Map<String, String> headers = {
      "Authorization": "Bearer $value",
      "Accept": "application/json",
      "Accept-Language": Get.locale.countryCode
    };
    String myUrl = "$serverUrl/me/images";
    final imageUpLoadRequest = http.MultipartRequest('POST', Uri.parse(myUrl));
    if (image != null) {
      final mimeTypeData =
          lookupMimeType(image.path, headerBytes: [0xff, 0xD8]).split("/");
      final file = await http.MultipartFile.fromPath("image", image.path,
          contentType: MediaType(mimeTypeData[0], mimeTypeData[1]));
      imageUpLoadRequest.files.add(file);
    }
    imageUpLoadRequest.headers['Accept'] = 'application/json';
    imageUpLoadRequest.headers['Content-Type'] = 'application/json';
    imageUpLoadRequest.headers['Accept-Language'] = Get.locale.countryCode;
    imageUpLoadRequest.headers.addAll(headers);

    try {
      final streamResponse = await imageUpLoadRequest.send();
      final response = await http.Response.fromStream(streamResponse);

      if (response.statusCode != 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        print(responseData);
        return null;
      }
      final Map<String, dynamic> responseData = json.decode(response.body);
      // _resetState();
      msgStatus = responseData["message"];
      // print(file);
      print(responseData);

      return responseData;
    } catch (e) {
      print(e);
      // print(file);
      return null;
    }
  }

  static getUserData(userId) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;

    print(userId);
    String myUrl = "$serverUrl/user/$userId";
    print(myUrl);
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

  static deleteImage(imgId) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;

    print(imgId);
    String myUrl = "$serverUrl/deleteimg/$imgId";
    print(myUrl);
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

  static getCalls(userId) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;

    print(userId);
    String myUrl = "$serverUrl/usercalls/$userId";
    print(myUrl);
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

  static addLike(userId) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;

    String myUrl = "$serverUrl/addlike/"+userId;
    final response = await http.get(
      Uri.parse(myUrl),
      headers: {
        'Accept': 'application/json',
        'Accept-Language': Get.locale.languageCode,
        'Authorization': 'Bearer $value'
      },
    );
    var info = json.decode(response.body);
    var status = info["success"];

    print('Response status : ${response.statusCode}');
    print('Response body : ${response.body}');
    return status;
  }

  static sendEmalForChangePassword(email) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;

    print(email);
    String myUrl = "$serverUrl/password/email";
    print(myUrl);
    final response = await http.post(
      Uri.parse(myUrl),
      headers: {
        'Accept-Language': Get.locale.languageCode,
        'Authorization': 'Bearer $value'
      },
      body: {"email":email}
    );
    var res = json.decode(response.body);
    print('Response status : ${response.statusCode}');
    print('Response body : ${response.body}');
    return res;
  }

}
