import 'package:discussion/tools/app_constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void showToast({String msg}) {
  Fluttertoast.showToast(
      backgroundColor: black,
      textColor: white,
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      timeInSecForIosWeb: 1);
}

// ignore: non_constant_identifier_names
Widget Loading() {
  return Center(
    child: CupertinoActivityIndicator(
      radius: ScreenUtil().setWidth(20),
      animating: true,
    ),
  );
}

// ignore: non_constant_identifier_names
Widget AppLoading() {
  return Center(
    child: Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      semanticContainer: true,
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.all(Radius.circular(ScreenUtil().radius(15))),
        side: BorderSide(
          width: ScreenUtil().setWidth(2),
          color: mainColor,
        ),
      ),
      child: Container(
        height: ScreenUtil().setWidth(100),
        width: ScreenUtil().setWidth(100),
        child: Center(
          child: Logo(
            size: 30,
          ),
        ),
      ),
    ),
  );
}

// ignore: non_constant_identifier_names
Widget Logo({double size}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SpinKitWave(
        size: ScreenUtil().setWidth(size),
        color: secColor,
        type: SpinKitWaveType.center,
      ),
      SpinKitWave(
        size: size,
        color: mainColor,
        type: SpinKitWaveType.center,
      ),
    ],
  );
}

void showAlert(
    {BuildContext context,
    String title,
    String content,
    String yes,
    String no,
    Function yesPressed,
    Function noPressed}) {
  showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
            title: Text(
              title,
              style:
                  TextStyle(fontFamily: mainFont, fontWeight: FontWeight.bold),
            ),
            content: Text(
              content,
              style: TextStyle(fontFamily: mainFont),
            ),
            actions: [
              CupertinoDialogAction(
                child: Text(
                  no,
                  style: TextStyle(fontFamily: mainFont, color: black),
                ),
                onPressed: noPressed,
              ),
              CupertinoDialogAction(
                child: Text(
                  yes,
                  style: TextStyle(fontFamily: mainFont, color: mainColor),
                ),
                onPressed: yesPressed,
              ),
            ],
          ));
}

void showLanguages(context) {
  showModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: context,
    builder: (context) {
      return CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
              onPressed: () {
                // changeLocale(
                // context,
                // 'ar',
                // );
              },
              child: Text(
                tr('arabic'),
                style: TextStyle(color: mainColor),
              )),
          CupertinoActionSheetAction(
              onPressed: () {
                // changeLocale(context, 'en');
              },
              child: Text(
                tr('english'),
                style: TextStyle(color: mainColor),
              ))
        ],
        title: Text(tr("change_language")),
      );
    },
  );
}

showUserPopUp(context, user) {
  Alert(
    context: context,
    // type: AlertType.info,
    closeIcon: Icon(Icons.close, color: Colors.white),
    title: "",
    style: AlertStyle(
      animationDuration: Duration(milliseconds: 250),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
        side: BorderSide(
          color: Colors.grey,
        ),
      ),
      overlayColor: Color.fromRGBO(0, 0, 0, .7),
      titleStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontFamily: mainFont,
          color: Color.fromRGBO(21, 110, 110, 1),
          fontSize: 15),
      constraints: BoxConstraints.expand(width: 300),
    ),
    content: StatefulBuilder(

      // You need this, notice the parameters below:
        builder: (BuildContext context, StateSetter setState) {
          return Column(
            children: [
          Container(
          margin: EdgeInsets.only(bottom: 0),
          height: 106,width: 106,
          alignment: Alignment.topRight,
          decoration: BoxDecoration(

          image: DecorationImage(image:
          user['image']==null?AssetImage(user['gender_id']==1?"assets/images/boy.png":"assets/images/girl.png"):NetworkImage("${"http://discussion-app.com"+"/"+user['image'].toString()}")
          ,fit: BoxFit.fill),
          borderRadius: BorderRadius.all(Radius.circular(53)),
          border: Border.all(color: Colors.white,width: 4),
          boxShadow: [
          BoxShadow(color: Color(0xff00000029),blurRadius: 6,offset: Offset(0, 6)),
          BoxShadow(color: Color(0xff00000029),blurRadius: 6,offset: Offset(0, 6)),
          BoxShadow(color: Color(0xff00000029),blurRadius: 6,offset: Offset(0, 6)),
          BoxShadow(color: Color(0xff00000029),blurRadius: 6,offset: Offset(0, 6))
          ]

          ),

          ),
              Container(
                margin: EdgeInsets.only(top: 15, bottom: 2),
                child: Text("${user['name']}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: mainFont,
                        color: Color(0xff156E6E),
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
              ),

              Container(
                margin: EdgeInsets.only(bottom: 12, right: 0, left: 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.all(1),
                            child: Icon(
                              Icons.location_on,
                              size: 21,
                              color: Color.fromRGBO(1, 1, 1, .5),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(1),
                            child: Text("${user['country'] == null ? "":user['country']['name']}".tr(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontFamily: mainFont,
                                    color: Color.fromRGBO(1, 1, 1, .6),
                                    fontSize: 15)),
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
              ),
              Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                height: .5,
                color: Color(0xffBFBEBE),
                margin: EdgeInsets.only(right: 0, left: 0, bottom: 10),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 12, right: 0, left: 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                          Container(
                            margin: EdgeInsets.all(2),
                            child: Text(
                                "${user['bio'] ?? ""} ",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontFamily: mainFont,
                                    color: Color.fromRGBO(1, 1, 1, .6),
                                    fontSize: 15)),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [

                          Column(
                            children: [
                              SvgPicture.asset(
                                like,
                                height: ScreenUtil().setHeight(20),
                                fit: BoxFit.contain,
                              ),
                              SizedBox(
                                height: ScreenUtil().setHeight(15),
                              ),
                              Text(
                                tr("likes"),
                                style: TextStyle(
                                  color: textColor,
                                  fontFamily: mainFont,
                                  fontSize: smallFontSize,
                                ),
                              ),
                              SizedBox(
                                height: ScreenUtil().setHeight(15),
                              ),
                              Text(
                                '${user["like_count"]}',
                                style: TextStyle(
                                  color: textColor,
                                  fontFamily: mainFont,
                                  fontSize: smallFontSize,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              SvgPicture.asset(
                                phone,
                                height: ScreenUtil().setHeight(20),
                                fit: BoxFit.contain,
                              ),
                              SizedBox(
                                height: ScreenUtil().setHeight(15),
                              ),
                              Text(
                                tr("calls"),
                                style: TextStyle(
                                  color: textColor,
                                  fontFamily: mainFont,
                                  fontSize: smallFontSize,
                                ),
                              ),
                              SizedBox(
                                height: ScreenUtil().setHeight(15),
                              ),
                              Text(
                                '${user["call_count"]}',
                                style: TextStyle(
                                  color: textColor,
                                  fontFamily: mainFont,
                                  fontSize: smallFontSize,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }),
    // desc: "Flutter is more awesome with RFlutter Alert.",
    buttons: [],
  ).show();
}

showMessagePopUp(context, message) {
  Alert(
    context: context,
    // type: AlertType.info,
    closeIcon: Icon(Icons.close, color: Colors.white),
    title: "",
    style: AlertStyle(
      animationDuration: Duration(milliseconds: 250),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
        side: BorderSide(
          color: Colors.grey,
        ),
      ),
      overlayColor: Color.fromRGBO(0, 0, 0, .7),
      titleStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontFamily: mainFont,
          color: Color.fromRGBO(21, 110, 110, 1),
          fontSize: 15),
      constraints: BoxConstraints.expand(width: 300),
    ),
    content: Container(
      height: MediaQuery.of(context).size.height/3,
      child: Column(
        children: [

          Image.asset("assets/images/ok.png",height: 90,width: 90,fit: BoxFit.fill,),
          SizedBox(
            height: ScreenUtil().setHeight(20),
          ),
          Text("${message}",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: mainFont,
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),

        ],
      )
    ),
    // desc: "Flutter is more awesome with RFlutter Alert.",
    buttons: [],
  ).show();
}
