import 'package:discussion/models/prefrences_model.dart';
import 'package:discussion/provider/dropdownbuttons_provider.dart';
import 'package:discussion/provider/prefrences_provider.dart';
import 'package:discussion/provider/profile_provider.dart';
import 'package:discussion/screens/call_screens/call_screen.dart';
import 'package:discussion/screens/call_screens/example_call.dart';
import 'package:discussion/screens/packages_screens/packages_screen.dart';
import 'package:discussion/services/api_services/topic_helper.dart';
import 'package:discussion/src/call_sample/call_sample.dart';
import 'package:discussion/tools/app_components.dart';
import 'package:discussion/tools/app_constants.dart';
import 'package:discussion/tools/design_utils.dart';
import 'package:discussion/views/nations_viewsTmp.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class PrefrencesView extends StatefulWidget {
  final int topicID;
  PrefrencesView({this.topicID});
  @override
  _PrefrencesViewState createState() => _PrefrencesViewState();
}

class _PrefrencesViewState extends State<PrefrencesView> {
  TopicHelper topicHelper = TopicHelper();
  int callID;

  _postTopic(int id, String gendre,check)async {
    if(false/*check && Provider.of<ProfileProvider>(context, listen: false).subscription.isEnded*/){
      showDialog(context: context, builder: (_)=>AlertDialog(
        backgroundColor: Colors.white,
        content: Text("pleaseSubscribeFirst",style: TextStyle(color: Colors.black,fontFamily: mainFont),).tr(),
        actions: [
          FlatButton(onPressed: (){}, child: Text("close",style: TextStyle(color: Colors.red,fontFamily: mainFont)).tr()),
          FlatButton(onPressed: (){}, child: Text("subscribe",style: TextStyle(color: Colors.green,fontFamily: mainFont)).tr()),
        ],
      ));
    }else{
      var info=await topicHelper.getAccessTokn(id, gendre,Provider.of<NationProvider>(context, listen: false).selectedId);
      Get.to(() => ExampleCall(
          parentContext: context,
        appId: info['app_id'].toString(),
        channelId: info['channel_id'].toString(),
        token: info['agora_token'].toString(),
        uid: int.parse(info['u_id']),
        topic: id,
        alwaysOpen:Provider.of<ProfileProvider>(context, listen: false).subscription!=null
      )).then((value) {Navigator.of(context).pop();Provider.of<ProfileProvider>(Get.context, listen: false).showLikeDialog(context);});
    }


  }

  @override
  Widget build(final BuildContext context) {
    return FutureBuilder<List<Prefrences>>(
        future: getPrefrences(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Prefrences> data = snapshot.data;
            print(snapshot.data[0].name);
            return _prefrencesListView(context, data);
          } else if (snapshot.hasError) {
            print(snapshot.error);
            return Center(
              child: Card(
                child: Container(
                  height: ScreenUtil().setHeight(150),
                  width: ScreenUtil().setWidth(250),
                  child: Center(
                    child: Text(tr('error_connection')),
                  ),
                ),
              ),
            );
          }
          print(snapshot.connectionState);
          print(snapshot.data);
          return Loading();
        });
  }

  _prefrencesListView(context, data) {
    double width = MediaQuery.of(context).size.width;
    return Consumer<PrefrencesProvider>(builder: (
      final BuildContext context,
      final PrefrencesProvider provider,
      final Widget child,
    ) {
      return Container(
        height: ScreenUtil().setHeight(300),
        width: width,
        child: Column(
          children: [
            Provider.of<ProfileProvider>(context, listen: false).subscription !=null &&
                (Provider.of<ProfileProvider>(context, listen: false).subscription.package_id == 3) ?
            _nationButton():Container(),
            SizedBox(
              height: 150,
              child: ListView.builder(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  itemCount: data.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      width: width,
                      height: ScreenUtil().setHeight(75),
                      child: CupertinoActionSheetAction(
                        onPressed: true?() {
                          print('topic: ${widget.topicID}');
                          print('gendre: ${data[index].name}');
                          _postTopic(widget.topicID, data[index].name,true);
                        }:(){},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Image.network(
                              data[index].image,
                              height: ScreenUtil().setHeight(40),
                              fit: BoxFit.contain,
                            ),
                            Text(
                              data[index].name,
                              style: TextStyle(
                                color: mainColor,
                                fontFamily: mainFont,
                                fontSize: fontSize,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
            false?
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  appButton(
                    sidePadding: 0,
                    buttonRadius: 15,
                    buttonText: tr("enterWithNoGender"),
                    buttonColor: mainColor,
                    fontFamily: mainFont,
                    textColor: white,
                    textSize: 17,
                    isBold: false,
                    onPressed: () {
                      _postTopic(widget.topicID, "BOTH",false);
                    },
                  ),
                  appButton(
                    sidePadding: 0,
                    buttonRadius: 15,
                    buttonText: tr("subscribe_now"),
                    buttonColor: Colors.red,
                    fontFamily: mainFont,
                    textColor: white,
                    textSize: 17,
                    isBold: false,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PackagesScreen()));
                    },
                  ),
                ],
              )
            ):Container(),

          ],
        )
      );
    });
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
          child: NationDropdownTmp(),
        ));
  }
}
