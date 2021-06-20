// import 'package:discussion/models/user_model.dart';
// import 'package:discussion/tools/app_constants.dart';
// import 'package:discussion/tools/design_utils.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// class ProfileViews extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<List<User>>(
//         future: getUser(),
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             List<User> data = snapshot.data;
//             print(snapshot.data[0].name);
//             return _profileListView(context, data);
//           } else if (snapshot.hasError) {
//             print(snapshot.error);
//             return Center(
//               child: Card(
//                 child: Container(
//                   height: ScreenUtil().setHeight(150),
//                   width: ScreenUtil().setWidth(250),
//                   child: Center(
//                     child: Text('${snapshot.error}'),
//                   ),
//                 ),
//               ),
//             );
//           }
//           return Loading();
//         });
//   }

//   _profileListView(context, data) {
//     return Padding(
//       padding: EdgeInsets.only(
//         right: ScreenUtil().setWidth(40),
//         left: ScreenUtil().setWidth(80),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           Column(
//             children: [
//               Card(
//                 clipBehavior: Clip.antiAliasWithSaveLayer,
//                 semanticContainer: true,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.all(
//                       Radius.circular(ScreenUtil().radius(23))),
//                 ),
//                 child: data[0].image == null
//                     ? Image.asset(
//                         example,
//                         fit: BoxFit.fill,
//                         height: ScreenUtil().setHeight(65),
//                         width: ScreenUtil().setWidth(65),
//                       )
//                     : Image.network(
//                         data[0].image,
//                         fit: BoxFit.fill,
//                         height: ScreenUtil().setHeight(65),
//                         width: ScreenUtil().setWidth(65),
//                       ),
//               ),
//               SizedBox(
//                 height: ScreenUtil().setHeight(15),
//               ),
//               Container(
//                 height: ScreenUtil().setHeight(35),
//                 width: ScreenUtil().setWidth(100),
//                 child: Text(
//                   data[0].bio == null? 'السيرة الذاتية: لا يوجد' :
//                   'السيره الذاتية: ${data[0].bio}',
//                   softWrap: true,
//                   overflow: TextOverflow.visible,
//                   style: TextStyle(
//                     color: mainColor,
//                     fontFamily: mainFont,
//                     fontSize: infoFontSize,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           Column(
//             children: [
//               SvgPicture.asset(
//                 like,
//                 height: ScreenUtil().setHeight(20),
//                 fit: BoxFit.contain,
//               ),
//               SizedBox(
//                 height: ScreenUtil().setHeight(15),
//               ),
//               Text(
//                 'عدد الإعجابات',
//                 style: TextStyle(
//                   color: textColor,
//                   fontFamily: mainFont,
//                   fontSize: smallFontSize,
//                 ),
//               ),
//               SizedBox(
//                 height: ScreenUtil().setHeight(15),
//               ),
//               Text(
//                 '${data[0].likeCount}',
//                 style: TextStyle(
//                   color: textColor,
//                   fontFamily: mainFont,
//                   fontSize: smallFontSize,
//                 ),
//               ),
//             ],
//           ),
//           Column(
//             children: [
//               SvgPicture.asset(
//                 phone,
//                 height: ScreenUtil().setHeight(20),
//                 fit: BoxFit.contain,
//               ),
//               SizedBox(
//                 height: ScreenUtil().setHeight(15),
//               ),
//               Text(
//                 'عدد المكالمات',
//                 style: TextStyle(
//                   color: textColor,
//                   fontFamily: mainFont,
//                   fontSize: smallFontSize,
//                 ),
//               ),
//               SizedBox(
//                 height: ScreenUtil().setHeight(15),
//               ),
//               Text(
//                 '${data[0].callCount}',
//                 style: TextStyle(
//                   color: textColor,
//                   fontFamily: mainFont,
//                   fontSize: smallFontSize,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
