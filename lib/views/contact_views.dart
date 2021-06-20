// import 'package:discussion/models/contact_model.dart';
// import 'package:discussion/provider/Contact_provider.dart';
// import 'package:discussion/tools/app_constants.dart';
// import 'package:discussion/tools/design_utils.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:provider/provider.dart';

// // ignore: must_be_immutable
// class ContactView extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<List<Contact>>(
//         future: getContact(),
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             List<Contact> data = snapshot.data;
//             print(snapshot.data);
//             return _nationListView(context, data);
//           } else if (snapshot.hasError) {
//             print(snapshot.error);
//             return Center(
//               child: Card(
//                 child: Container(
//                   height: ScreenUtil().setHeight(150),
//                   width: ScreenUtil().setWidth(250),
//                   child: Center(
//                     child: Text(tr('error_connection')),
//                   ),
//                 ),
//               ),
//             );
//           }
//           print(snapshot.connectionState);
//           print(snapshot.data);
//           return Loading();
//         });
//   }

//   _nationListView(context, data) {
//     return Consumer<ContactProvider>(
//       builder: (
//         final BuildContext context,
//         final ContactProvider provider,
//         final Widget child,
//       ) {
//         double width = MediaQuery.of(context).size.width;
//         return Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Text(data.content,
//                   style: TextStyle(
//                       color: mainColor,
//                       fontFamily: mainFont,
//                       fontSize: buttonFontSize,
//                       fontWeight: FontWeight.bold)),
//               SizedBox(
//                 height: ScreenUtil().setHeight(30),
//               ),
//               // GestureDetector(
//               //     onTap: provider.launchURL(data.website), child: Logo()),
//               // SizedBox(
//               //   height: ScreenUtil().setHeight(30),
//               // ),
//               // _phoneData(),
//               // SizedBox(
//               //   height: ScreenUtil().setHeight(30),
//               // ),
//               // Container(
//               //   width: width,
//               //   child: Row(
//               //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               //     children: [
//               //       _socialButton(
//               //         onTap: provider.launchURL(data.facebook),
//               //         image: facebook,
//               //       ),
//               //       _socialButton(
//               //         onTap: provider.launchURL(data.twitter),
//               //         image: twitter,
//               //       ),
//               //       _socialButton(
//               //         onTap: provider.launchURL(data.instagram),
//               //         image: instagram,
//               //       ),
//               //       _socialButton(
//               //         onTap: provider.launchURL(data.snapshot),
//               //         image: snapchat,
//               //       ),
//               //       _socialButton(
//               //         onTap: provider.launchURL('https://wa.me/${data.whatsapp}'),
//               //         image: whatsapp,
//               //       ),
//               //     ],
//               //   ),
//               // ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   _phoneData() {
//     return Column(
//       children: [],
//     );
//   }

//   _socialButton({VoidCallback onTap, String image}) {
//     return Padding(
//       padding: EdgeInsets.only(
//         right: ScreenUtil().setWidth(6),
//         left: ScreenUtil().setWidth(6),
//       ),
//       child: GestureDetector(
//         onTap: onTap,
//         child: Image.asset(
//           image,
//           fit: BoxFit.contain,
//           height: ScreenUtil().setHeight(35),
//         ),
//       ),
//     );
//   }
// }
