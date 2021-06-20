import 'package:discussion/provider/dropdownbuttons_provider.dart';
import 'package:discussion/screens/auth_screens/login_screen.dart';
import 'package:discussion/screens/intro_screens/intro_screen.dart';
import 'package:discussion/screens/main_screens/main_screen.dart';
import 'package:discussion/services/local_services/shared_prefrences.dart';
import 'package:discussion/tools/app_components.dart';
import 'package:discussion/tools/app_constants.dart';
import 'package:discussion/views/language_views.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class LanguageScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LanguageScreenState();
  }
}

class LanguageScreenState extends State<LanguageScreen> {
  final SharedPrefService databaseHelper = SharedPrefService();
  void changeLocale(BuildContext context, String languageCode) {
    Get.updateLocale(Locale(languageCode));
    context.setLocale(Locale(languageCode));
    databaseHelper.setValue("language", languageCode);
    print(languageCode);
    Get.back();
  }

  _readIntro() {
    databaseHelper.getValue('intro').whenComplete(() {
      print(databaseHelper.value);
      databaseHelper.value != 'intro'
          ? Get.to(() => IntroScreen())
          : databaseHelper.getValue("token").whenComplete(() {
              databaseHelper.value == null || databaseHelper.value == "0"
                  ? Get.to(() => LoginScreen())
                  : Get.to(()=>MainScreen());
            });
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LanguageProvider>(context);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  logo,
                  height: ScreenUtil().setHeight(50),
                  width: ScreenUtil().setWidth(100),
                  fit: BoxFit.contain,
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: ScreenUtil().setWidth(4.0),
                      right: ScreenUtil().setWidth(4.0)),
                  child: Text(
                    "Discussion",
                    style: TextStyle(
                        fontFamily: mainFont,
                        fontWeight: FontWeight.bold,
                        fontSize: largeFontSize,
                        color: logoColor),
                  ),
                )
              ],
            ),
            SizedBox(
              height: ScreenUtil().setHeight(60),
            ),
            _langButton(),
            SizedBox(
              height: ScreenUtil().setHeight(20),
            ),
            appButton(
              buttonColor: mainColor,
              buttonText: provider.name == 'عربي' ? 'التالي' : 'next',
              fontFamily: mainFont,
              sidePadding: 60,
              buttonRadius: 5,
              textSize: buttonFontSize,
              textColor: white,
              onPressed: () {
                provider.name == 'عربي'
                    ? changeLocale(context, 'ar')
                    : changeLocale(context, 'en');
                _readIntro();
              },
            ),
          ],
        ),
      ),
    );
  }

  _langButton() {
    return Padding(
      padding: EdgeInsets.only(
        left: ScreenUtil().setWidth(60),
        right: ScreenUtil().setWidth(60),
      ),
      child: Container(
          width: MediaQuery.of(Get.context).size.width,
          // height: ScreenUtil().setHeight(60),
          decoration: BoxDecoration(
            color: white,
            borderRadius:
                BorderRadius.all(Radius.circular(ScreenUtil().setWidth(30))),
            border: Border.all(
              color: black,
            ),
          ),
          child: LanguageDropdown()),
    );
  }
}
