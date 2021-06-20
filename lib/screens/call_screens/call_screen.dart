//import 'package:discussion/screens/packages_screens/packages_screen.dart';
//import 'package:discussion/tools/app_components.dart';
//import 'package:discussion/tools/app_constants.dart';
//import 'package:easy_localization/easy_localization.dart';
//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter_screenutil/flutter_screenutil.dart';
//import 'package:flutter_svg/flutter_svg.dart';
//
//class CallScreen extends StatefulWidget {
//  final int id;
//  CallScreen({this.id});/**/
//  @override
//  _CallScreenState createState() => _CallScreenState();
//}
//
//class _CallScreenState extends State<CallScreen> {
//  final _localRenderer = new RTCVideoRenderer();
//
//  void popUp() {
//    showDialog(
//        context: context,
//        builder: (BuildContext context) {
//          return AlertDialog(
//            backgroundColor: Colors.white,
//            shape: RoundedRectangleBorder(
//              borderRadius:
//                  BorderRadius.all(Radius.circular(ScreenUtil().radius(15))),
//            ),
//            title: Row(
//              mainAxisAlignment: MainAxisAlignment.center,
//              children: [
//                Text(
//                  tr("rate"),
//                  style: TextStyle(
//                    color: textColor,
//                    fontSize: titleFontSize,
//                    fontFamily: mainFont,
//                  ),
//                ),
//                SvgPicture.asset(like),
//              ],
//            ),
//            content: Text(
//              tr("more_time"),
//              textAlign: TextAlign.center,
//              style: TextStyle(
//                color: mainColor,
//                fontSize: homeFontSize,
//                fontFamily: mainFont,
//              ),
//            ),
//            actions: <Widget>[
//              Container(
//                width: MediaQuery.of(context).size.width,
//                child: Row(
//                  mainAxisAlignment: MainAxisAlignment.center,
//                  children: [
//                    appButton(
//                      sidePadding: 50,
//                      buttonRadius: 8,
//                      buttonText: tr("subscribe"),
//                      buttonColor: rateColor,
//                      fontFamily: mainFont,
//                      textColor: white,
//                      textSize: buttonFontSize,
//                      onPressed: () {
//                        Navigator.push(
//                            context,
//                            MaterialPageRoute(
//                                builder: (context) => PackagesScreen()));
//                      },
//                    ),
//                  ],
//                ),
//              ),
//            ],
//          );
//        });
//  }
//
//  @override
//  dispose() {
//    _localRenderer.dispose();
//    super.dispose();
//  }
//
//  @override
//  void initState() {
//    initRenderers();
//    _getUserMedia();
//    super.initState();
//  }
//
//  _getUserMedia() async {
//    final Map<String, dynamic> mediaConstraints = {
//      "audio": true,
//      "video": {"facingMode": "user"}
//    };
//    MediaStream stream = await navigator.getUserMedia(mediaConstraints);
//    _localRenderer.srcObject = stream;
//  }
//
//  initRenderers() async {
//    await _localRenderer.initialize();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    double height = MediaQuery.of(context).size.height;
//    double width = MediaQuery.of(context).size.width;
//    return Scaffold(
//      body: Stack(
//        alignment: FractionalOffset.center,
//        children: [
//          // Image.asset(example, fit: BoxFit.fill, height: height, width: width),
//          // Column(
//          //   mainAxisAlignment: MainAxisAlignment.center,
//          //   children: [
//          // Card(
//          //   clipBehavior: Clip.antiAliasWithSaveLayer,
//          //   elevation: 1.0,
//          //   semanticContainer: true,
//          //   shape: RoundedRectangleBorder(
//          //     borderRadius: BorderRadius.all(
//          //         Radius.circular(ScreenUtil().radius(100))),
//          //   ),
//          //   child: Image.asset(example,
//          //       fit: BoxFit.fill,
//          //       height: ScreenUtil().setWidth(200),
//          //       width: ScreenUtil().setWidth(200)),
//          // ),
//          //     SizedBox(
//          //       height: ScreenUtil().setHeight(30),
//          //     ),
//          //     Text('عبدالله الشهراني',
//          //         style: TextStyle(
//          //           color: white,
//          //           fontFamily: mainFont,
//          //           fontSize: callFontSize,
//          //           fontWeight: FontWeight.w700,
//          //         )),
//          //     SizedBox(
//          //       height: ScreenUtil().setHeight(30),
//          //     ),
//          //     Text('15:00 min',
//          //         style: TextStyle(
//          //           color: white,
//          //           fontFamily: mainFont,
//          //           fontSize: callFontSize,
//          //           fontWeight: FontWeight.w700,
//          //         )),
//          //     SizedBox(
//          //       height: ScreenUtil().setHeight(100),
//          //     ),
//          //     Padding(
//          //       padding: EdgeInsets.only(
//          //         right: ScreenUtil().setWidth(125),
//          //         left: ScreenUtil().setWidth(125),
//          //       ),
//          //       child: Row(
//          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//          //         children: [
//          //           Image.asset(mic),
//          //           GestureDetector(
//          //               onTap: popUp, child: SvgPicture.asset(mute)),
//          //         ],
//          //       ),
//          //     ),
//          //   ],
//          // ),
//          Container(
//            height: ScreenUtil().setHeight(200),
//            width: ScreenUtil().setWidth(200),
//            child: RTCVideoView(_localRenderer),
//          ),
//        ],
//      ),
//    );
//  }
//}
