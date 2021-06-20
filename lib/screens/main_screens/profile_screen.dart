import 'package:discussion/provider/auth_provider.dart';
import 'package:discussion/screens/intro_screens/language_screen.dart';
import 'package:discussion/screens/packages_screens/packages_screen.dart';
import 'package:discussion/screens/profile_screens/contact_screen.dart';
import 'package:discussion/screens/profile_screens/edit_profile_screen.dart';
import 'package:discussion/screens/profile_screens/policy_screen.dart';
import 'package:discussion/services/api_services/profile_helper.dart';
import 'package:discussion/services/local_services/shared_prefrences.dart';
import 'package:discussion/tools/app_constants.dart';
import 'package:discussion/tools/design_utils.dart';
import 'package:discussion/views/gallery_views.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProfileScreenState();
  }
}

class ProfileScreenState extends State<ProfileScreen> {
  ProfileHelper profileHelper = ProfileHelper();
  SharedPrefService databaseHelper = SharedPrefService();
  var profile;
  bool _isLoad = true;

  _getProfile() {
    profileHelper.getProfile().whenComplete(() {
      setState(() {
        print("####3tt$profile");
        profile = profileHelper.info["data"]["user"];
        _isLoad = false;
        print("####3tt$profile");
        print(profileHelper.info["data"]["user"]["id"].toString());
        databaseHelper.setValue(
            'user', profileHelper.info["data"]["user"]["id"].toString());
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _getProfile();
    print(Get.locale.languageCode);
    print(Get.locale.languageCode.runtimeType);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
        builder: (context, provider, child) => Scaffold(
              backgroundColor: white,
              appBar: AppBar(
                backgroundColor: white,
                elevation: 0.0,
                centerTitle: true,
                title: Text(
                  tr("profile"),
                  style: TextStyle(
                      color: mainColor,
                      fontFamily: mainFont,
                      fontWeight: FontWeight.w700),
                ),
                actions: [
                  GestureDetector(
                    onTap: () {
                      print("###");
                      //print("-->>${profile}");
                      Get.to(() => EditProfileScreen(
                            name: profile["name"],
                            bio: profile["bio"],
                            image: profile["image"],
                            gendre: profile["gender"]["name"],
                            callCount: profile["call_count"],
                            likeCount: profile["like_count"],
                          ));
                    },
                    child: Padding(
                      padding: EdgeInsets.all(ScreenUtil().setWidth(20.0)),
                      child: SvgPicture.asset(settings),
                    ),
                  ),
                ],
              ),
              body: ListView(
                children: [
                  SizedBox(
                    height: ScreenUtil().setHeight(50),
                  ),
                  _profileInfo(),
                  SizedBox(
                    height: ScreenUtil().setHeight(10),
                  ),
                  _titleProfile(
                    title: tr("gallery"),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(10),
                  ),
                  _profileImages(),
                  SizedBox(
                    height: ScreenUtil().setHeight(25),
                  ),
                  _titleProfile(
                    title: tr("settings"),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(15),
                  ),
                  _profileSettings(
                    title: tr('packages'),
                    image: language,
                    size: 20,
                    onTap: () {
                      Get.to(() => PackagesScreen());
                    },
                  ),

                  SizedBox(
                    height: ScreenUtil().setHeight(15),
                  ),
                  _profileSettings(
                    title: tr('call'),
                    image: call,
                    size: 20,
                    onTap: () {
                      Get.to(() => ContactScreen());
                    },
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(15),
                  ),
                  _profileSettings(
                    title: tr("share"),
                    image: next,
                    size: 25,
                    onTap: () {
                      shareApp(tr("shareApp"));
                    },
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(15),
                  ),
                  _profileSettings(
                      title: tr("terms"),
                      image: question,
                      size: 25,
                      onTap: () {
                        Get.to(() => PolicyScreen());
                      }),
                  SizedBox(
                    height: ScreenUtil().setHeight(15),
                  ),
                  _profileSettings(
                      title: tr("logout"),
                      image: logout,
                      size: 25,
                      onTap: () {
                        provider.logout();
                      }),
                  SizedBox(
                    height: ScreenUtil().setHeight(80),
                  ),
                ],
              ),
            ));
  }

  _profileInfo() {
    return _isLoad == true
        ? AppLoading()
        : Padding(
            padding: Get.locale.languageCode == "en"
                ? EdgeInsets.only(
                    right: ScreenUtil().setWidth(80),
                    left: ScreenUtil().setWidth(40),
                  )
                : EdgeInsets.only(
                    right: ScreenUtil().setWidth(40),
                    left: ScreenUtil().setWidth(80),
                  ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Card(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      semanticContainer: true,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                            Radius.circular(ScreenUtil().radius(23))),
                      ),
                      child: profile["image"] != null
                          ? Image.network(
                              profile["image"].toString().contains("http")?profile["image"]:serverdomain+"/"+profile["image"],
                              fit: BoxFit.fill,
                              height: ScreenUtil().setHeight(100),
                              width: ScreenUtil().setWidth(100),
                            )
                          : profile["gender"]["name"] == "Male" ||
                                  profile["gender"]["name"] == "ذكر"
                              ? Image.asset(
                                  boy,
                                  fit: BoxFit.fill,
                                  height: ScreenUtil().setHeight(100),
                                  width: ScreenUtil().setWidth(100),
                                )
                              : Image.asset(
                                  girl,
                                  fit: BoxFit.fill,
                                  height: ScreenUtil().setHeight(100),
                                  width: ScreenUtil().setWidth(100),
                                ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(15),
                    ),
                    profile["bio"] == null
                        ? Container()
                        : LimitedBox(
                            maxHeight: ScreenUtil().setHeight(100),
                            maxWidth: ScreenUtil().setWidth(140),
                            child: Text(
                              '${tr("bio")}: ${profile["bio"]}',
                              softWrap: true,
                              overflow: TextOverflow.visible,
                              style: TextStyle(
                                color: mainColor,
                                fontFamily: mainFont,
                                fontSize: infoFontSize,
                              ),
                            ),
                          ),
                  ],
                ),
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
                      '${profile["like_count"]}',
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
                      '${profile["call_count"]}',
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
          );
  }

  _profileSettings(
      {String title, String image, double size, VoidCallback onTap}) {
    return Padding(
      padding: EdgeInsets.only(
        right: ScreenUtil().setWidth(45),
        left: ScreenUtil().setWidth(45),
      ),
      child: ListTile(
        onTap: onTap,
        title: Text(
          title,
          style: TextStyle(
            color: mainColor,
            fontFamily: mainFont,
            fontSize: fontSize,
          ),
        ),
        leading: SvgPicture.asset(
          image,
          height: ScreenUtil().setHeight(size),
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  _profileImages() {
    double width = MediaQuery.of(Get.context).size.width;
    return Padding(
      padding: EdgeInsets.only(
        right: ScreenUtil().setWidth(45),
        left: ScreenUtil().setWidth(45),
      ),
      child: Container(
        width: width,
        height: ScreenUtil().setHeight(110),
        child: GalleryView(),
      ),
    );
  }

  _titleProfile({String title}) {
    return Padding(
      padding: EdgeInsets.only(
        right: ScreenUtil().setWidth(40),
        left: ScreenUtil().setWidth(40),
      ),
      child: Text(
        title,
        style: TextStyle(
            color: mainColor,
            fontFamily: mainFont,
            fontSize: buttonFontSize,
            fontWeight: FontWeight.w700),
      ),
    );
  }

  static shareApp(message)async{
    await Share.share(message.replaceAll("{0}", APP_INSTALLATION_LINK));
  }
}
