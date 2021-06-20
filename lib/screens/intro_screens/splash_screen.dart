import 'package:discussion/provider/intro_provider.dart';
import 'package:discussion/tools/app_constants.dart';
import 'package:discussion/tools/design_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> {
  _readSplashScreen(BuildContext context) {
    final provider = Provider.of<IntroProvider>(context, listen: false);
    provider.readIntro();
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () => _readSplashScreen(context));
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: white,
      body: Container(
        height: height,
        width: width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Logo(size: 50),
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
      ),
    );
  }
}
