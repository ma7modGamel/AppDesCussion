import 'package:discussion/screens/auth_screens/login_screen.dart';
import 'package:discussion/screens/intro_screens/language_screen.dart';
import 'package:discussion/screens/main_screens/main_screen.dart';
import 'package:discussion/services/local_services/shared_prefrences.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class IntroProvider with ChangeNotifier {
  SharedPrefService databaseHelper = SharedPrefService();
  String intro;

  readIntro() {
    databaseHelper.getValue("intro").whenComplete(() {
      databaseHelper.value == null
          ? Get.to(() => LanguageScreen())
          : databaseHelper.getValue("token").whenComplete(() {
              databaseHelper.value == null || databaseHelper.value == '0'
                  ? Get.to(() => LoginScreen())
                  : Get.to(() => MainScreen());
            });
    });
  }
}
