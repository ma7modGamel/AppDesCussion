import 'package:discussion/provider/profile_provider.dart';
import 'package:discussion/screens/call_screens/example_call.dart';
import 'package:discussion/services/api_services/profile_helper.dart';
import 'package:discussion/services/api_services/topic_helper.dart';
import 'package:discussion/tools/app_constants.dart';
import 'package:discussion/tools/design_utils.dart';
import 'package:discussion/views/prefrences_views.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {
  ProfileHelper profileHelper = ProfileHelper();
  TopicHelper topicHelper = TopicHelper();
  var profile;
  var topic;
  bool _isLoad = true;
  int topicId;
  int callID;

  _getProfile() {
    profileHelper.getProfile().whenComplete(() {
      setState(() {
        profile = profileHelper.info["data"]["user"];
        _getTopic();
      });
    });
  }

  _getTopic() {
    topicHelper.getTopic().whenComplete(() {
      setState(() {
        topic = topicHelper.info["data"];
        _isLoad = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();

    _getProfile();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ProfileProvider>(context, listen: false)
          .getCurrentSub();
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          tr("home"),
          style: TextStyle(
              color: mainColor,
              fontFamily: mainFont,
              fontWeight: FontWeight.w700),
        ),
      ),
      body: _isLoad == true
          ? AppLoading()
          : ListView(
              children: [
                SizedBox(
                  height: ScreenUtil().setHeight(50),
                ),
                _profileInfo(),
                _categoriesTitle(),
                SizedBox(
                  height: ScreenUtil().setHeight(12),
                ),
                LimitedBox(
                  maxHeight: ScreenUtil().setHeight(100000),
                  maxWidth: width,
                  child: _categoriesList(),
                ),
              ],
            ),
    );
  }

  _categoriesTitle() {
    return Padding(
      padding: EdgeInsets.only(
        right: ScreenUtil().setWidth(20),
        left: ScreenUtil().setWidth(20),
      ),
      child: Text(tr('main_section'),
          style: TextStyle(
              color: mainColor,
              fontFamily: mainFont,
              fontSize: titleFontSize,
              fontWeight: FontWeight.w700)),
    );
  }

  _categoriesList() {
    return Padding(
      padding: EdgeInsets.only(
          left: ScreenUtil().setWidth(25), right: ScreenUtil().setWidth(25)),
      child: GridView.builder(
          shrinkWrap: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          physics: NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemCount: topic.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.all(ScreenUtil().setWidth(5)),
              child: Stack(
                alignment: FractionalOffset.bottomCenter,
                children: [
                  GestureDetector(
                    onTap: () async{
                      /*if(Provider.of<ProfileProvider>(context, listen: false).subscription==null){
                        var info=await topicHelper.getAccessTokn(topic[index]["id"], "3");
                        Get.to(() => ExampleCall(
                          parentContext: context,
                            appId: info['app_id'].toString(),
                            channelId: info['channel_id'].toString(),
                            token: info['agora_token'].toString(),
                            uid: int.parse(info['u_id']),
                            alwaysOpen:Provider.of<ProfileProvider>(context, listen: false).subscription!=null)).then((value) => Provider.of<ProfileProvider>(context, listen: false).showLikeDialog(context));
                            }
                            else{
                      setState(() {
                      topicId = topic[index]["id"];
                      _showCupertino();
                      });
                        }*/
                      topicId = topic[index]["id"];
                      _showCupertino();

                    },
                    child: Card(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      semanticContainer: true,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                            Radius.circular(ScreenUtil().radius(10))),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: black.withOpacity(0.1),
                          borderRadius: BorderRadius.all(
                              Radius.circular(ScreenUtil().radius(10))),
                        ),
                        child: Image.network(
                          '${topic[index]["image"]}',
                          height: ScreenUtil().setHeight(160),
                          width: ScreenUtil().setWidth(155),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: ScreenUtil().setHeight(12),
                        left: ScreenUtil().setWidth(15),
                        right: ScreenUtil().setWidth(15)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: ScreenUtil().setWidth(45),
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: Text('${topic[index]["name"]}',
                                style: TextStyle(
                                    color: white,
                                    fontFamily: mainFont,
                                    fontSize: fontSize,
                                    fontWeight: FontWeight.w700)),
                          ),
                        ),
                        Container(
                          height: ScreenUtil().setHeight(25),
                          width: ScreenUtil().setWidth(55),
                          decoration: BoxDecoration(
                            color: mainColor,
                            borderRadius: BorderRadius.all(
                                Radius.circular(ScreenUtil().radius(16))),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: ScreenUtil().setWidth(8),
                              right: ScreenUtil().setWidth(8),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('${topic[index]["live_count"]}',
                                    style: TextStyle(
                                        color: white,
                                        fontFamily: mainFont,
                                        fontSize: smallFontSize,
                                        fontWeight: FontWeight.w700)),
                                Icon(Icons.message,
                                    color: white,
                                    size: ScreenUtil().setWidth(20)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }

  _profileInfo() {
    return Padding(
      padding: EdgeInsets.only(
        left: ScreenUtil().setWidth(35),
        right: ScreenUtil().setWidth(35),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
      Provider.of<ProfileProvider>(context, listen: false).subscription == null?
      Container():
      Provider.of<ProfileProvider>(context, listen: false).subscription.id != 4?
      SvgPicture.asset(
        Provider.of<ProfileProvider>(context, listen: false).subscription.id==3?crown:
        Provider.of<ProfileProvider>(context, listen: false).subscription.id == 2?stars:star,
        height: ScreenUtil().setHeight(25),
        fit: BoxFit.contain,
      ):Image.asset(stars3,height: ScreenUtil().setHeight(25),
        fit: BoxFit.contain,),
              Container(
                height: ScreenUtil().setWidth(100),
                width: ScreenUtil().setWidth(100),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: profile["image"] != null
                        ? NetworkImage(
                            profile["image"].toString().contains("http")?profile["image"]:serverdomain+"/"+profile["image"],
                          )
                        : profile["gender"]["name"] == "Male" ||
                                profile["gender"]["name"] == "ذكر"
                            ? AssetImage(boy)
                            : AssetImage(girl),
                    fit: BoxFit.fill,
                  ),
                  color: secColor.withOpacity(0.2),
                  borderRadius: BorderRadius.all(
                      Radius.circular(ScreenUtil().radius(50))),
                ),
              ),
            ],
          ),
          Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("${profile["name"]}",
                      softWrap: true,
                      style: TextStyle(
                          color: mainColor,
                          fontFamily: mainFont,
                          fontSize: packageFontSize,
                          fontWeight: FontWeight.w700)),
                  profile["bio"] == null
                      ? Container()
                      : LimitedBox(
                          maxHeight: ScreenUtil().setHeight(100),
                          maxWidth: ScreenUtil().setWidth(100),
                          child: Text('${profile["bio"]}',
                              softWrap: true,
                              overflow: TextOverflow.visible,
                              style: TextStyle(
                                color: mainColor,
                                fontFamily: mainFont,
                                fontSize: infoFontSize,
                              )),
                        ),
                ],
              ),
              SizedBox(
                height: ScreenUtil().setHeight(45),
              ),
              Padding(
                padding: EdgeInsets.only(left: ScreenUtil().setWidth(20.0)),
                child: Row(
                  children: [
                    Column(
                      children: [
                        SvgPicture.asset(like),
                        SizedBox(
                          height: ScreenUtil().setHeight(4),
                        ),
                        Text("${profile["like_count"]}",
                            style: TextStyle(
                              color: mainColor,
                              fontFamily: mainFont,
                              fontSize: buttonFontSize,
                            )),
                      ],
                    ),
                    SizedBox(
                      width: ScreenUtil().setWidth(50),
                    ),
                    Column(
                      children: [
                        SvgPicture.asset(phone),
                        SizedBox(
                          height: ScreenUtil().setHeight(4),
                        ),
                        Text("${profile["call_count"]}",
                            style: TextStyle(
                              color: mainColor,
                              fontFamily: mainFont,
                              fontSize: buttonFontSize,
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _showCupertino() {
    return showCupertinoModalPopup(
      context: Get.context,
      builder: (context) => Material(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        child: CupertinoActionSheet(
          title: Text(
              Provider.of<ProfileProvider>(context, listen: false).subscription != null?tr("choose_side")
                  :tr("PleaseSubscrbeToSelectGender"),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: mainColor,
              fontFamily: mainFont,
              fontSize: fontSize,
              fontWeight: FontWeight.w700,
            ),
          ),
          actions: [
            PrefrencesView(
              topicID: topicId,
            ),
          ],
        ),
      ),
    );
  }
}
