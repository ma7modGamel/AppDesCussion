import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

appButton({
  double sidePadding,
  double textSize,
  double buttonRadius,
  String buttonText,
  String fontFamily,
  Color buttonColor,
  Color textColor,
  VoidCallback onPressed,
  int height:50,
  isBold:true
}) {
  return Padding(
    padding: EdgeInsets.only(
        right: ScreenUtil().setWidth(sidePadding),
        left: ScreenUtil().setWidth(sidePadding)),
    child: ElevatedButton(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Container(
        height: ScreenUtil().setHeight(height),
        child: Center(
          child: Text(buttonText,
              style: TextStyle(
                color: textColor,
                fontFamily: fontFamily,
                fontSize: textSize,
                fontWeight: isBold?FontWeight.bold:FontWeight.normal
              )),
        ),
      ),
      style: ElevatedButton.styleFrom(
        primary: buttonColor,
        onPrimary: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
              Radius.circular(ScreenUtil().radius(buttonRadius))),
        ),
      ),
      onPressed: onPressed,
    ),
  );
}

appTextField({
  double sidePadding,
  TextEditingController controller,
  TextInputType keyboardType,
  bool isPassword,
  bool autofocus,
  Color borderColor,
  Color hintColor,
  Color textColor,
  Function validator,
  double fontSize,
  double prefixSize,
  String hintText,
  String fontFamily,
  String prefixImage,
  int maxLength,
}) {
  return Padding(
    padding: EdgeInsets.only(
      left: ScreenUtil().setWidth(sidePadding),
      right: ScreenUtil().setWidth(sidePadding),
    ),
    child: Container(
      height: ScreenUtil().setHeight(50),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: borderColor,
            width: ScreenUtil().setWidth(1),
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          left: ScreenUtil().setWidth(20),
          right: ScreenUtil().setWidth(20),
        ),
        child: TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: isPassword,
          validator: validator,
          autofocus: autofocus == null ? false : autofocus,
          style: TextStyle(
            fontSize: fontSize,
            fontFamily: fontFamily,
            color: textColor,
          ),
          maxLength: maxLength,
          decoration: InputDecoration(
            border: InputBorder.none,
            disabledBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            focusedErrorBorder: InputBorder.none,
            hintText: hintText,
            hintStyle: TextStyle(
              color: hintColor,
              fontSize: fontSize,
              fontFamily: fontFamily,
            ),
            prefixIcon: Padding(
              padding: EdgeInsets.all(ScreenUtil().setWidth(10.0)),
              child: SizedBox(
                height: ScreenUtil().setHeight(prefixSize),
                child: SvgPicture.asset(
                  prefixImage,
                  height: ScreenUtil().setHeight(20),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
