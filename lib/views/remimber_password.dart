



import 'package:discussion/services/api_services/profile_helper.dart';
import 'package:discussion/tools/app_components.dart';
import 'package:discussion/tools/app_constants.dart';
import 'package:discussion/tools/design_utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';

class RememberPage extends StatefulWidget {
  RememberPage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _RememberPageState createState() => _RememberPageState();
}

class _RememberPageState extends State<RememberPage> {

  TextEditingController emailP = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    return Scaffold(
appBar: AppBar(
  backgroundColor: mainColor,
  title: Text("تذكر كلمه المرور",style: TextStyle(fontFamily: mainFont,fontSize: 15),),
),
      body:Column(
        mainAxisAlignment: MainAxisAlignment.center,
    children: [

      Container(
        margin: EdgeInsets.only(top: 15,bottom: 15,left: 30,right: 30),
        child: Text("من فضلك ادخل البريد الالكتروني الخاص بك لتتمكن من تغيير كلمه المرور",style: TextStyle(fontFamily: mainFont,fontSize: 17,),textAlign: TextAlign.center,),
      ),
      appTextField(
        controller: emailP,
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
          setState(() {

          });
        },
      ),
      SizedBox(
        height: ScreenUtil().setHeight(30),
      ),

      appButton(
          buttonColor: mainColor,
          textSize: buttonFontSize,
          buttonRadius: 5,
          buttonText: tr('send'),
          fontFamily: mainFont,
          sidePadding: 35,
          textColor: white,
          onPressed:emailP.text.isEmpty?null: ()async {
            await ProfileHelper.sendEmalForChangePassword(emailP.text);
            showMessagePopUp(context,tr("rememberMessage"));
          }),
    ],
    ));
  }



  @override
  void initState() {
    emailP.addListener(() {
      setState(() {

      });
    });
  }

}
