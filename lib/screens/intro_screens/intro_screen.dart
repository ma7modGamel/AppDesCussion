import 'package:discussion/screens/auth_screens/login_screen.dart';
import 'package:discussion/services/local_services/shared_prefrences.dart';
import 'package:discussion/tools/app_constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overboard/flutter_overboard.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class IntroScreen extends StatefulWidget {
  @override
  IntroScreenState createState() => IntroScreenState();
}

class IntroScreenState extends State<IntroScreen>
    with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _globalKey = new GlobalKey<ScaffoldState>();
  SharedPrefService databaseHelper = SharedPrefService();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Overboard Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
        primarySwatch: Colors.blue,
          buttonColor: Colors.blue
    ),
    home: Scaffold(
      //backgroundColor: Color(0xff3063A4),
      key: _globalKey,
      body: OverBoard(
        pages: pages,
        showBullets: true,
        skipText: tr("skip"),
        finishText: tr("done"),
        nextText: tr("next"),
        //textColor: mainColor,
        //textFont: mainFont,
        //buttonColor: Colors.blue,
        skipCallback: () {
          Get.to(() => LoginScreen());
          databaseHelper.setValue("intro", "intro");
        },
        finishCallback: () {
          Get.to(() => LoginScreen());
          databaseHelper.setValue("intro", "intro");
        },
      ),
    ));
  }

  final pages = [
    PageModel.withChild(
      color: white,
      doAnimateChild: true,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            intro1,
          ),
          SizedBox(
            height: ScreenUtil().setHeight(20),
          ),
          Text(
            tr("discussion"),
            style: TextStyle(
                color: mainColor,
                fontSize: titleFontSize,
                fontFamily: mainFont,
                fontWeight: FontWeight.w700),
          ),
          Text(
            tr("intro_1"),
            style: TextStyle(
                color: textColor,
                fontSize: buttonFontSize,
                fontFamily: mainFont,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    ),
    PageModel.withChild(
      color: white,
      doAnimateChild: true,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            intro2,
          ),
          SizedBox(
            height: ScreenUtil().setHeight(20),
          ),
          Text(
            tr("pormote"),
            style: TextStyle(
                color: mainColor,
                fontSize: titleFontSize,
                fontFamily: mainFont,
                fontWeight: FontWeight.w700),
          ),
          Text(
            tr("intro_2"),
            style: TextStyle(
                color: textColor,
                fontSize: buttonFontSize,
                fontFamily: mainFont,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    ),
    PageModel.withChild(
      color: white,
      doAnimateChild: true,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            intro3,
          ),
          SizedBox(
            height: ScreenUtil().setHeight(20),
          ),
          Text(
            tr("communicate"),
            style: TextStyle(
                color: mainColor,
                fontSize: titleFontSize,
                fontFamily: mainFont,
                fontWeight: FontWeight.w700),
          ),
          Text(
            tr("intro_3"),
            style: TextStyle(
                color: textColor,
                fontSize: buttonFontSize,
                fontFamily: mainFont,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    ),
  ];
}
