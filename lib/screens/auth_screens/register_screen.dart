import 'package:discussion/provider/auth_provider.dart';
import 'package:discussion/screens/auth_screens/login_screen.dart';
import 'package:discussion/views/gendre_views.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:discussion/tools/app_constants.dart';
import 'package:discussion/tools/app_components.dart';
import 'package:get/get.dart';
import 'package:discussion/views/nations_views.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  GlobalKey<FormState> _registerKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
        builder: (context, provider, child) => Scaffold(
              backgroundColor: white,
              body: Form(
                key: _registerKey,
                child: ListView(
                  children: [
                    SizedBox(
                      height: ScreenUtil().setHeight(100),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          right: ScreenUtil().setWidth(35),
                          left: ScreenUtil().setWidth(35)),
                      child: Text(
                        tr('register_screen'),
                        style: TextStyle(
                            color: mainColor,
                            fontFamily: mainFont,
                            fontSize: largeFontSize,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(30),
                    ),
                    SvgPicture.asset(
                      register,
                      height: ScreenUtil().setHeight(125),
                      // width: ScreenUtil().setWidth(100),
                      fit: BoxFit.contain,
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(35),
                    ),
                    appTextField(
                      controller: provider.name,
                      sidePadding: 30,
                      autofocus: false,
                      isPassword: false,
                      fontFamily: mainFont,
                      fontSize: buttonFontSize,
                      hintColor: textColor,
                      hintText: tr('name'),
                      textColor: black,
                      borderColor: Colors.grey[300],
                      prefixImage: man,
                      prefixSize: 20,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return tr("validation_message");
                        }
                      },
                    ),
                    appTextField(
                      controller: provider.email,
                      sidePadding: 30,
                      autofocus: false,
                      isPassword: false,
                      fontFamily: mainFont,
                      fontSize: buttonFontSize,
                      hintColor: textColor,
                      hintText: tr("email"),
                      textColor: black,
                      borderColor: Colors.grey[300],
                      prefixImage: email,
                      prefixSize: 20,
                      keyboardType: TextInputType.emailAddress,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return tr("validation_message");
                        }
                      },
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(30),
                    ),
                    appTextField(
                      controller: provider.password,
                      sidePadding: 30,
                      autofocus: false,
                      isPassword: true,
                      fontFamily: mainFont,
                      fontSize: buttonFontSize,
                      hintColor: textColor,
                      hintText: tr('password'),
                      textColor: black,
                      borderColor: Colors.grey[300],
                      prefixImage: lock,
                      prefixSize: 20,
                      keyboardType: TextInputType.text,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return tr("validation_message");
                        }
                      },
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(30),
                    ),
                    _nationButton(),
                    SizedBox(
                      height: ScreenUtil().setHeight(30),
                    ),
                    _gendreButton(),
                    SizedBox(
                      height: ScreenUtil().setHeight(40),
                    ),
                    appButton(
                        buttonColor: mainColor,
                        textSize: buttonFontSize,
                        buttonRadius: 5,
                        buttonText: tr('register_screen'),
                        fontFamily: mainFont,
                        sidePadding: 35,
                        textColor: white,
                        onPressed: () {
                          if (_registerKey.currentState.validate()) {
                            provider.register();
                          }
                        }),
                    SizedBox(
                      height: ScreenUtil().setHeight(20),
                    ),
                    _loginButton(),
                    SizedBox(
                      height: ScreenUtil().setHeight(85),
                    ),
                  ],
                ),
              ),
            ));
  }

  _loginButton() {
    return GestureDetector(
      onTap: () {
        Get.to(LoginScreen());
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            tr("have_account"),
            style: TextStyle(
                color: textColor,
                fontFamily: mainFont,
                fontWeight: FontWeight.w700,
                fontSize: dataFontSize),
          ),
          SizedBox(
            width: ScreenUtil().setWidth(4),
          ),
          Text(
            tr("login_screen"),
            style: TextStyle(
                color: mainColor,
                fontSize: dataFontSize,
                fontFamily: mainFont,
                fontWeight: FontWeight.w700),
          )
        ],
      ),
    );
  }

  _gendreButton() {
    double width = MediaQuery.of(Get.context).size.width;
    return Padding(
        padding: EdgeInsets.only(
          left: ScreenUtil().setWidth(35),
          right: ScreenUtil().setWidth(35),
        ),
        child: Container(
          width: width,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.grey[300],
              ),
            ),
          ),
          child: GendreDropDown(),
        ));
  }

  _nationButton() {
    double width = MediaQuery.of(Get.context).size.width;
    return Padding(
        padding: EdgeInsets.only(
          left: ScreenUtil().setWidth(35),
          right: ScreenUtil().setWidth(35),
        ),
        child: Container(
          width: width,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.grey[300],
              ),
            ),
          ),
          child: NationDropdown(),
        ));
  }
}
