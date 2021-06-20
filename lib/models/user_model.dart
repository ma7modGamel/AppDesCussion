import 'dart:convert';
import 'package:discussion/tools/app_constants.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class User {
  String name;
  String email;
  Map<String, dynamic> country;
  Map<String, dynamic> gender;
  String bio;
  String image;
  int likeCount;
  int callCount;
  int isVip;
  int isAdmin;

  User(this.name, this.email, this.country, this.gender, this.bio, this.image,
      this.likeCount, this.callCount, this.isVip, this.isAdmin);
  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    country = json['country'];
    gender = json['gender'];
    bio = json['bio'];
    image = json['image'];
    likeCount = json['like_count'];
    callCount = json['call_count'];
    isVip = json['is_vip'];
    isAdmin = json['is_admin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    if (this.country != null) {
      data['country'] = this.country;
    }
    if (this.gender != null) {
      data['gender'] = this.gender;
    }
    data['bio'] = this.bio;
    data['image'] = this.image;
    data['like_count'] = this.likeCount;
    data['call_count'] = this.callCount;
    data['is_vip'] = this.isVip;
    data['is_admin'] = this.isAdmin;
    return data;
  }
}

class Country {
  int id;
  String name;

  Country({this.id, this.name});

  Country.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

// ignore: missing_return
Future<List<User>> getUser(String token) async {
  final requestURL = serverUrl + '/me';
  final response = await http.get(Uri.parse(requestURL), headers: {
    'Accept': 'application/json',
    'Accept-Language': Get.locale.languageCode,
    'Authorization': 'Bearer $token'
  });
  var jsonResponse = json.decode(response.body);
  List<User> users = [];

  if (response.statusCode == 200) {
    User user = User(
        jsonResponse["data"]["user"]["name"],
        jsonResponse["data"]["user"]["email"],
        jsonResponse["data"]["user"]["country"],
        jsonResponse["data"]["user"]["gender"],
        jsonResponse["data"]["user"]["bio"],
        jsonResponse["data"]["user"]["image"],
        jsonResponse["data"]["user"]["like_count"],
        jsonResponse["data"]["user"]["call_count"],
        jsonResponse["data"]["user"]["is_vip"],
        jsonResponse["data"]["user"]["is_admin"]);
    users.add(user);
    print(users[0].name);
    return users;
  }
}

getToken() {}
