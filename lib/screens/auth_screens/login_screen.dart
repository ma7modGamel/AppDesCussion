import 'package:discussion/provider/auth_provider.dart';
import 'package:discussion/screens/auth_screens/register_screen.dart';
import 'package:discussion/views/remimber_password.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:discussion/tools/app_constants.dart';
import 'package:discussion/tools/app_components.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> {
  final _loginKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, provider, child) => Scaffold(
        backgroundColor: white,
        body: Form(
          key: _loginKey,
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
                  tr("login_screen"),
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
                login,
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
                hintText: tr('login_data'),
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
                hintText: tr("password"),
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
              Container(
                margin: EdgeInsets.only(top: 20),
                alignment: Alignment.center,
                child:InkWell(
                  child: Text(
                    tr("rememberPassword"),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: textColor,
                        fontFamily: mainFont,
                        fontWeight: FontWeight.normal,
                        decoration: TextDecoration.underline,
                        fontSize: 16),
                  ),
                  onTap: (){
                      Get.to(()=>RememberPage());
                  },
                )
              ),
              SizedBox(
                height: ScreenUtil().setHeight(130),
              ),
              appButton(
                  buttonColor: mainColor,
                  textSize: buttonFontSize,
                  buttonRadius: 5,
                  buttonText: tr('login_screen'),
                  fontFamily: mainFont,
                  sidePadding: 35,
                  textColor: white,
                  onPressed: () {
                    if (_loginKey.currentState.validate()) {
                      provider.login();
                    }
                  }),
              SizedBox(
                height: ScreenUtil().setHeight(20),
              ),
              _registerButton(),
              SizedBox(
                height: ScreenUtil().setHeight(85),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _registerButton() {
    return GestureDetector(
      onTap: () {
        Get.to(() => RegisterScreen());
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            tr("no_account"),
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
            tr("register_screen"),
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
}
